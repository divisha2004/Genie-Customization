codeunit 58101 "Order fulfilment Management"
{
    trigger OnRun()
    var

    begin

    end;

    local procedure GetSalesOrders()
    begin
        SalesHeader.RESET;
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        SalesHeader.SetRange("Completely Shipped", false);
        IF SalesHeader.FindFirst() then
            repeat
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("Completely Shipped", false);
                if SalesLine.FindFirst() THEN
                    repeat
                        Clear(AvailableQty);
                        iF CheckStockAvailable(SalesLine, AvailableQty) then
                            InitWhseLogEntries(SalesHeader, SalesLine, AvailableQty);
                    UNTIL SalesLine.Next() = 0;
            until SalesHeader.Next() = 0;
    end;

    local procedure CheckStockAvailable(SalesLine: Record "Sales Line"; Var AvailableQty: Decimal): Boolean
    begin

    end;

    local procedure GetNextShipmentDate(ShipMethodCode: CODE[10]; CalcDate: Date) NexShipmentDate: Date
    var
        ShipmentMethod: Record "Shipment Method";
    begin
        if ShipmentMethod.get(ShipMethodCode) then begin
            CASE ShipmentMethod."Shipment Day" of
                ShipmentMethod."Shipment Day"::" ":
                    exit;
                ShipmentMethod."Shipment Day"::Monday:
                    begin
                        NexShipmentDate := CalcDate
                    end;
                ShipmentMethod."Shipment Day"::Tuesday:
                    begin

                    end;
                ShipmentMethod."Shipment Day"::Wednesday:
                    begin

                    end;
                ShipmentMethod."Shipment Day"::Thursday:
                    begin

                    end;
                ShipmentMethod."Shipment Day"::Friday:
                    begin

                    end;
                ShipmentMethod."Shipment Day"::"Any Day":
                    begin

                    end;
            end;
        END;
    end;

    local procedure InitWhseLogEntries(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; QtyAvailable: Decimal)
    var
        WarehouseLogEntries: Record "Auto Whse. Ship Log Entries";
    begin
        WarehouseLogEntries.Init();
        WarehouseLogEntries."Entry No." := GetLastWhseLogEntryNo();
        WarehouseLogEntries."Sales Order No." := SalesHeader."No.";
        WarehouseLogEntries."Sales Order Line No." := SalesLine."Line No.";
        WarehouseLogEntries."Item No." := SalesLine."No.";
        WarehouseLogEntries."Part No." := SalesLine."Part No.";
        WarehouseLogEntries.Description := SalesLine.Description;
        WarehouseLogEntries."Location Code" := SalesLine."Location Code";
        WarehouseLogEntries."Variant Code" := SalesLine."Variant Code";
        WarehouseLogEntries."Shipment Method Code" := SalesHeader."Shipment Method Code";
        WarehouseLogEntries."Order Quantity" := SalesLine.Quantity;
        WarehouseLogEntries.Insert(true);
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
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AvailableQty: Decimal;
}
