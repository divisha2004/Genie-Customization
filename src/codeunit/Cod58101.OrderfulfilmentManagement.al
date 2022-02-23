codeunit 58101 "Order fulfilment Management"
{
    trigger OnRun()
    var

    begin

    end;

    procedure ProcessWhseRequest()
    var
        WarehouseShipHeader: record "Warehouse Shipment Header";
        TempCustomer: Record "Top Customers By Sales Buffer" temporary;
        WhseRequest: Record "Warehouse Request";
        Increment: Integer;
        GetSourceDocuments: report "Get Source Documents";
        SalesHeader: Record "Sales Header";
    begin

        WhseRequest.Reset();
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        WhseRequest.SetRange("Shipment Date", WorkDate());
        WhseRequest.SetRange("Destination Type", WhseRequest."Destination Type"::Customer);
        WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Order");
        WhseRequest.SetRange("Completely Handled", false);
        if WhseRequest.FindFirst() then begin
            Increment := 1;
            TempCustomer.Reset();
            TempCustomer.DeleteAll();
            repeat
                TempCustomer.Reset();
                TempCustomer.SetRange(CustomerNo, WhseRequest."Destination No.");
                if not TempCustomer.FindFirst() then begin
                    TempCustomer.Init();
                    TempCustomer."CustomerNo" := WhseRequest."Destination No.";
                    TempCustomer.Ranking := Increment;
                    TempCustomer.Insert();
                    Increment += 1;
                end;
            until WhseRequest.Next() = 0;
        end else
            exit;

        TempCustomer.Reset();
        TempCustomer.SetCurrentKey(Ranking);
        if TempCustomer.FindFirst() THEN
            repeat
                WhseRequest.Reset();
                WhseRequest.SetRange("Shipment Date", WorkDate());
                WhseRequest.SetRange("Destination Type", WhseRequest."Destination Type"::Customer);
                WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Order");
                WhseRequest.SetRange("Destination No.", TempCustomer.CustomerNo);
                WhseRequest.SetRange("Completely Handled", false);
                IF WhseRequest.FindSet() then begin
                    WarehouseShipHeader.INIT;
                    WarehouseShipHeader."No." := '';
                    WarehouseShipHeader."Location Code" := WhseRequest."Location Code";
                    WarehouseShipHeader."Shipment Date" := WhseRequest."Shipment Date";
                    WarehouseShipHeader.Insert(true);

                    //To make Get Source document in Warehouse shipment lines.
                    GetSourceDocuments.SetOneCreatedShptHeader(WarehouseShipHeader);
                    GetSourceDocuments.SetSkipBlocked(true);
                    GetSourceDocuments.UseRequestPage(false);
                    WhseRequest.SetRange("Location Code", WarehouseShipHeader."Location Code");
                    GetSourceDocuments.SetTableView(WhseRequest);
                    GetSourceDocuments.SetHideDialog(true);
                    GetSourceDocuments.RunModal;
                    Clear(GetSourceDocuments);

                    //To process warehouse shipment lines for Item availablity checking
                    ProcessWarehouseShipmentLines(WarehouseShipHeader);

                    //To update next shipment date for all sales orders
                    if SalesHeader.get(SalesHeader."Document Type"::Order, WhseRequest."Source No.") then
                        UpdateWhseRequestShipmentDate(WhseRequest."Source No.", GetNextShipmentDate(SalesHeader, WhseRequest."Shipment Date"))
                end;
            UNTIL TempCustomer.Next() = 0;
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
        if WarehouseShipLine.FindSet() then begin

            //Creating Warehouse Pick
            Clear(WhseShipmentCreatePick);
            clear(ReleaseWhseShipment);
            ReleaseWhseShipment.Release(WarehouseShipHeader);
            WhseShipmentCreatePick.SetWhseShipmentLine(WarehouseShipLine, WarehouseShipHeader);
            WhseShipmentCreatePick.SetHideValidationDialog(TRUE);
            WhseShipmentCreatePick.SetHideNothingToHandleError(true);
            WhseShipmentCreatePick.UseRequestPage(FALSE);
            WhseShipmentCreatePick.RunModal;
            WhseShipmentCreatePick.GetResultMessage;
            Clear(WhseShipmentCreatePick);


            WarehouseActLine.reset;       //Registering Warehouse Pick
            WarehouseActLine.SetRange("Whse. Document Type", WarehouseActLine."Whse. Document Type"::Shipment);
            WarehouseActLine.SetRange("Whse. Document No.", WarehouseShipHeader."No.");
            WarehouseActLine.SetRange("Activity Type", WarehouseActLine."Activity Type"::Pick);
            if WarehouseActLine.FindSet() then begin
                Clear(WMSMgt);
                clear(WhseActivityRegister);
                WMSMgt.CheckBalanceQtyToHandle(WarehouseActLine);
                WhseActivityRegister.ShowHideDialog(TRUE);
                WhseActivityRegister.Run(WarehouseActLine);
                UpdateWhseLogEntries(WarehouseShipLine); //To update whseLog entries Registered Pick
            END
            ELSE begin
                ReopenWhseDocument(WarehouseShipHeader);
                WarehouseShipHeader.Delete();
            end;
        end else
            WarehouseShipHeader.DELETE;
    end;


    local procedure CheckStockAvailable(SalesLine: Record "Sales Line"; Var AvailableQty: Decimal): Boolean
    var
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
    begin
        Clear(AvailableQty);
        AvailableQty := SalesInfoPaneMgt.CalcAvailability(SalesLine);
        IF AvailableQty = 0 then //if Available Qty is zero means that same stock qty available.
            AvailableQty := SalesLine."Outstanding Quantity";
        EXIT(AvailableQty >= 0)
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

    local procedure UpdateSOShipmentDate(SalesOrderNo: Code[20]; NextShipmentDate: Date);
    var
        SalesHeader: Record "Sales Header";
        ReleaseDocument: Codeunit "Release Sales Document";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", SalesOrderNo);
        if SalesHeader.FindFirst() then begin
            if SalesHeader."Shipment Date" = NextShipmentDate then
                exit;
            Clear(ReleaseDocument);
            ReleaseDocument.PerformManualReopen(SalesHeader);
            SalesHeader.Validate("Shipment Date", NextShipmentDate);
            SalesHeader.Modify();
            ReleaseDocument.PerformManualRelease(SalesHeader);
        end;
    end;

    local procedure UpdateWhseLogEntries(WarehouseShipLine: record "Warehouse Shipment Line")
    var
        WarehouseLogEntries: Record "Auto Whse. Ship Log Entries";
        RegisterdWhseActLine: record "Registered Whse. Activity Line";
        WhseShipHeader: Record "Warehouse Shipment Header";

        SalesHeader: Record "Sales Header";
    begin
        WhseShipHeader.Get(WarehouseShipLine."No.");
        ReopenWhseDocument(WhseShipHeader);
        repeat
            SalesHeader.get(SalesHeader."Document Type"::Order, WarehouseShipLine."Source No.");
            WarehouseLogEntries.Init();
            WarehouseLogEntries."Entry No." := GetLastWhseLogEntryNo();
            WarehouseLogEntries."Sales Order No." := WarehouseShipLine."Source No.";
            WarehouseLogEntries."Sales Order Line No." := WarehouseShipLine."Source Line No.";
            WarehouseLogEntries."Item No." := WarehouseShipLine."Item No.";
            WarehouseLogEntries."Part No." := WarehouseShipLine."Part No.";
            WarehouseLogEntries.Description := WarehouseShipLine.Description;
            WarehouseLogEntries."Location Code" := WarehouseShipLine."Location Code";
            WarehouseLogEntries."Variant Code" := WarehouseShipLine."Variant Code";
            WarehouseLogEntries."Shipment Method Code" := SalesHeader."Shipment Method Code";
            WarehouseLogEntries."Order Quantity" := WarehouseShipLine.Quantity;
            WarehouseLogEntries."Whse Shipment No." := WarehouseShipLine."No.";
            WarehouseLogEntries."Processed Shipment Date" := WarehouseShipLine."Shipment Date";

            RegisterdWhseActLine.reset;
            RegisterdWhseActLine.SetRange("Whse. Document Type", RegisterdWhseActLine."Whse. Document Type"::Shipment);
            RegisterdWhseActLine.SetRange("Whse. Document No.", WarehouseShipLine."No.");
            if RegisterdWhseActLine.FindSet() then
                WarehouseLogEntries."Registered Pick No." := RegisterdWhseActLine."No.";

            if WarehouseShipLine."Completely Picked" then
                WarehouseLogEntries.Status := WarehouseLogEntries.Status::"Completely picked";

            if ((WarehouseShipLine.Quantity > WarehouseShipLine."Qty. Picked") AND (WarehouseShipLine."Qty. Picked" > 0)) then begin
                WarehouseLogEntries.Status := WarehouseLogEntries.Status::"Partially picked";
                WarehouseShipLine.Validate(Quantity, WarehouseShipLine."Qty. Picked");
                WarehouseLogEntries."Next Shipment Date" := GetNextShipmentDate(SalesHeader, WorkDate());
                UpdateWhseRequestShipmentDate(WarehouseShipLine."Source No.", WarehouseLogEntries."Next Shipment Date");
                WarehouseShipLine.Modify();
            end;
            if WarehouseShipLine."Qty. Picked" = 0 then begin
                WarehouseLogEntries.Status := WarehouseLogEntries.Status::"Not Picked Yet";
                WarehouseLogEntries."Out of Stock" := TRUE;
                WarehouseShipLine.Delete();
            end;
            WarehouseLogEntries.Insert();
        until WarehouseShipLine.Next() = 0;
        ReleaseWhseDocument(WhseShipHeader);
    end;

    local procedure ReleaseWhseDocument(WhseShipHeader: Record "Warehouse Shipment Header")
    var
        ReleaseWhseShipment: Codeunit "Whse.-Shipment Release";
    begin
        ReleaseWhseShipment.Release(WhseShipHeader);
    end;

    local procedure ReopenWhseDocument(WhseShipHeader: Record "Warehouse Shipment Header")
    var
        ReleaseWhseShipment: Codeunit "Whse.-Shipment Release";
    begin
        ReleaseWhseShipment.Reopen(WhseShipHeader);
    end;


    procedure UpdateWhseRequestShipmentDate(SalesOrderNo: code[20]; NextShipmentDate: Date)

    var
        WhseRequest: Record "Warehouse Request";
    begin
        WhseRequest.Reset();
        WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Sales Order");
        WhseRequest.SetRange("Source No.", SalesOrderNo);
        WhseRequest.SetRange("Completely Handled", false);
        if WhseRequest.FindFirst() then begin
            WhseRequest."Shipment Date" := NextShipmentDate;
            WhseRequest."Expected Shipment Date" := NextShipmentDate;
            WhseRequest.Modify();
        end;
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

}
