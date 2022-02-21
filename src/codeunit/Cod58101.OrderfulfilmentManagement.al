codeunit 58101 "Order fulfilment Management"
{
    trigger OnRun()
    var

    begin

    end;


    procedure ProcessWhseRequest()
    var
        WarehouseShipHeader: record "Warehouse Shipment Header";
    begin
        Increment := 1;
        Customer.Reset();
        if Customer.FindFirst() THEN
            repeat
                WhseRequest.Reset();
                WhseRequest.SetRange("Shipment Date", Today);
                WhseRequest.SetRange("Destination Type", WhseRequest."Destination Type"::Customer);
                WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Order");
                WhseRequest.SetRange("Destination No.", Customer."No.");
                IF WhseRequest.FindSet() then begin
                    WarehouseShipHeader.INIT;
                    WarehouseShipHeader."No." := '';
                    WarehouseShipHeader."Location Code" := WhseRequest."Location Code";
                    WarehouseShipHeader."Shipment Date" := WhseRequest."Shipment Date";
                    WarehouseShipHeader.Insert(true);

                    GetSourceDocuments.SetOneCreatedShptHeader(WarehouseShipHeader);
                    GetSourceDocuments.SetSkipBlocked(true);
                    GetSourceDocuments.UseRequestPage(false);
                    WhseRequest.SetRange("Location Code", WarehouseShipHeader."Location Code");
                    GetSourceDocuments.SetTableView(WhseRequest);
                    GetSourceDocuments.RunModal;
                    Clear(GetSourceDocuments);
                    ProcessWarehouseShipmentLines(WarehouseShipHeader);
                end;
            UNTIL CUSTOMER.Next() = 0;
    end;

    local procedure ProcessWarehouseShipmentLines(WarehouseShipHeader: Record "Warehouse Shipment Header")
    var
        WarehouseShipLine: Record "Warehouse Shipment Line";
        WarehouseActLine: Record "Warehouse Activity Line";
        SalesLineItemAvailQty: Decimal;
        ReleaseWhseShipment: Codeunit "Whse.-Shipment Release";
        WhseShipmentCreatePick: report "Whse.-Shipment - Create Pick";
        WhseActivityRegister: codeunit "Whse.-Activity-Register";
        WMSMgt: Codeunit "WMS Management";
    begin
        WarehouseShipLine.Reset();
        WarehouseShipLine.SetRange("No.", WarehouseShipHeader."No.");
        WarehouseShipLine.SetRange("Source Document", WarehouseShipLine."Source Document"::"Sales Order");
        if WarehouseShipLine.FindFirst() then begin
            repeat
                clear(SalesLineItemAvailQty);
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", WarehouseShipLine."Source No.");
                SalesLine.SetRange("Line No.", WarehouseShipLine."Source Line No.");

                if SalesLine.FindFirst() THEN begin
                    CheckStockAvailable(SalesLine, SalesLineItemAvailQty);
                    if (SalesLineItemAvailQty <= 0) then begin
                        WarehouseShipLine.Delete();
                        InitWhseLogEntries(SalesLine, WarehouseShipLine, SalesLineItemAvailQty, 0);
                    end else begin
                        if SalesLine."Outstanding Quantity" > SalesLineItemAvailQty then begin
                            WarehouseShipLine.Validate(Quantity, SalesLineItemAvailQty);
                            InitWhseLogEntries(SalesLine, WarehouseShipLine, SalesLineItemAvailQty, 1);
                            WarehouseShipLine.Modify(true);
                        end else
                            if SalesLine."Outstanding Quantity" = SalesLineItemAvailQty THEN begin
                                InitWhseLogEntries(SalesLine, WarehouseShipLine, SalesLineItemAvailQty, 2);
                            end ELSE
                                InitWhseLogEntries(SalesLine, WarehouseShipLine, SalesLineItemAvailQty, 2);
                    end;
                end;
            until WarehouseShipLine.Next() = 0;

            WarehouseShipLine.Reset();
            WarehouseShipLine.SetRange("No.", WarehouseShipHeader."No.");
            WarehouseShipLine.SetRange("Source Document", WarehouseShipLine."Source Document"::"Sales Order");
            if WarehouseShipLine.FindFirst() then begin

                //Creating Warehouse Pick
                Clear(WhseShipmentCreatePick);
                clear(ReleaseWhseShipment);
                ReleaseWhseShipment.Release(WarehouseShipHeader);
                WhseShipmentCreatePick.SetWhseShipmentLine(WarehouseShipLine, WarehouseShipHeader);
                WhseShipmentCreatePick.SetHideValidationDialog(TRUE);
                WhseShipmentCreatePick.UseRequestPage(FALSE);
                WhseShipmentCreatePick.RunModal;
                WhseShipmentCreatePick.GetResultMessage;
                Clear(WhseShipmentCreatePick);

                //Registering Warehouse Pick
                WarehouseActLine.reset;
                WarehouseActLine.SetRange("Whse. Document Type", WarehouseActLine."Whse. Document Type"::Shipment);
                WarehouseActLine.SetRange("Whse. Document No.", WarehouseShipHeader."No.");
                WarehouseActLine.SetRange("Activity Type", WarehouseActLine."Activity Type"::Pick);
                if WarehouseActLine.FindSet() then begin
                    Clear(WMSMgt);
                    clear(WhseActivityRegister);
                    WMSMgt.CheckBalanceQtyToHandle(WarehouseActLine);
                    WhseActivityRegister.Run(WarehouseActLine);
                    UpdateWhseLogEntries(WarehouseShipLine);
                end;
            end else begin
                WarehouseShipHeader.delete();
            end;
        end else begin
            WarehouseShipHeader.Delete();
        end;
    end;


    local procedure CheckStockAvailable(SalesLine: Record "Sales Line"; Var
                                                                            AvailableQty: Decimal): Boolean
    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
    begin
        Clear(AvailableQty);
        AvailableQty := SalesInfoPaneMgt.CalcAvailability(SalesLine);
        EXIT(AvailableQty > 0)
    end;

    procedure GetNextShipmentDate(Var SalesHeader: Record "Sales Header"; OrderDate: Date) NexShipmentDate: Date
    var

    begin

        CASE SalesHeader."Shipment Day" of
            SalesHeader."Shipment Day"::" ":
                exit;
            SalesHeader."Shipment Day"::Monday:
                NexShipmentDate := CalcDate('CD+WD1', OrderDate);
            SalesHeader."Shipment Day"::Tuesday:
                NexShipmentDate := CalcDate('CD+WD2', OrderDate);
            SalesHeader."Shipment Day"::Wednesday:
                NexShipmentDate := CalcDate('CD+WD3', OrderDate);
            SalesHeader."Shipment Day"::Thursday:
                NexShipmentDate := CalcDate('CD+WD4', OrderDate);
            SalesHeader."Shipment Day"::Friday:
                NexShipmentDate := CalcDate('CD+WD5', OrderDate);
            SalesHeader."Shipment Day"::"Customer Requested Date":
                NexShipmentDate := SalesHeader."Shipment Date";
        end;
    END;


    local procedure InitWhseLogEntries(SalesLine: Record "Sales Line"; WhseShipLine: Record "Warehouse Shipment Line"; QtyAvailable: Decimal; Status: Integer)
    var
        WarehouseLogEntries: Record "Auto Whse. Ship Log Entries";
    begin
        WarehouseLogEntries.Init();
        WarehouseLogEntries."Entry No." := GetLastWhseLogEntryNo();
        WarehouseLogEntries."Sales Order No." := SalesLine."Document No.";
        WarehouseLogEntries."Sales Order Line No." := SalesLine."Line No.";
        WarehouseLogEntries."Item No." := SalesLine."No.";
        WarehouseLogEntries."Part No." := SalesLine."Part No.";
        WarehouseLogEntries.Description := SalesLine.Description;
        WarehouseLogEntries."Location Code" := SalesLine."Location Code";
        WarehouseLogEntries."Variant Code" := SalesLine."Variant Code";
        WarehouseLogEntries."Shipment Method Code" := SalesHeader."Shipment Method Code";
        WarehouseLogEntries."Order Quantity" := SalesLine.Quantity;
        WarehouseLogEntries."Available Quantity" := QtyAvailable;
        WarehouseLogEntries."Whse Shipment No." := WhseShipLine."No.";
        if QtyAvailable <= 0 then
            WarehouseLogEntries."Out of Stock" := true;
        WarehouseLogEntries.Status := Status;
        IF WarehouseLogEntrieS.Status = WarehouseLogEntries.Status::"Not picked yet" THEN begin
            WarehouseLogEntries."Remaining Qty to Ship" := SalesLine.Quantity - QtyAvailable;
            WarehouseLogEntries."Next Shipment Date" := GetNextShipmentDate(SalesHeader, Today);
        end;
        if WarehouseLogEntries.Status = WarehouseLogEntries.Status::"Partially picked" then begin
            WarehouseLogEntries."Remaining Qty to Ship" := SalesLine.Quantity - QtyAvailable;
            WarehouseLogEntries."Next Shipment Date" := GetNextShipmentDate(SalesHeader, Today);
            WarehouseLogEntries."Out of Stock" := true;
        end;
        if WarehouseLogEntries.Status = WarehouseLogEntries.Status::"Completely picked" then
            WarehouseLogEntries."Remaining Qty to Ship" := 0;
        WarehouseLogEntries.Insert(true);
    end;

    local procedure UpdateSalesHeader(SalesOrderNo: Code[20]; Status: Integer)
    var
        SalesHeader: Record "Sales Header";
        ReleaseDocument: Codeunit "Release Sales Document";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", SalesOrderNo);
        if SalesHeader.FindFirst() then
            if Status IN [0, 1] then begin
                Clear(ReleaseDocument);
                ReleaseDocument.PerformManualReopen(SalesHeader);
                SalesHeader.Validate("Shipment Date", GetNextShipmentDate(SalesHeader, Today));
                SalesHeader.Modify();
                ReleaseDocument.PerformManualRelease(SalesHeader);
            end;
    end;

    local procedure UpdateWhseLogEntries(WarehouseShipLine: record "Warehouse Shipment Line")
    var
        WarehouseLogEntries: Record "Auto Whse. Ship Log Entries";
        RegisterdWhseActLine: record "Registered Whse. Activity Line";
    begin
        WarehouseLogEntries.RESET;
        WarehouseLogEntries.SetRange("Sales Order No.", WarehouseShipLine."Source No.");
        WarehouseLogEntries.SetRange("Whse Shipment No.", WarehouseShipLine."No.");
        if WarehouseLogEntries.FindFirst() then
            repeat
                RegisterdWhseActLine.reset;
                RegisterdWhseActLine.SetRange("Whse. Document Type", RegisterdWhseActLine."Whse. Document Type"::Shipment);
                RegisterdWhseActLine.SetRange("Whse. Document No.", WarehouseShipLine."No.");
                if RegisterdWhseActLine.FindSet() then begin
                    WarehouseLogEntries."Registered Pick No." := RegisterdWhseActLine."No.";
                    WarehouseLogEntries.Modify();
                end;
            UNTIL WarehouseLogEntries.Next() = 0;
    end;

    local procedure GetLastWhseLogEntryNo(): Integer;
    var
        WarehouseLogEntries: Record "Auto Whse. Ship Log Entries";
    begin
        WarehouseLogEntries.reset();
        if WarehouseLogEntries.FindLast() then
            exit(WarehouseLogEntries."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    var
        GetSourceDocuments: Report "Get Source Documents";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AvailableQty: Decimal;

        Increment: Integer;
        WhseRequest: record "Warehouse Request";

        Customer: Record Customer;
}
