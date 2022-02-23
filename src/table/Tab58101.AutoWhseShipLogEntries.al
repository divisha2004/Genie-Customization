table 58101 "Auto Whse. Ship Log Entries"
{
    Caption = 'Auto Whse. Ship Log Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(50; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }
        field(60; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(70; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(80; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(90; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(100; "Whse Shipment No."; Code[20])
        {
            Caption = 'Whse Shipment No.';
            DataClassification = ToBeClassified;
        }
        field(110; "Posted Whse Ship No."; Code[20])
        {
            Caption = 'Posted Whse Ship No.';
            DataClassification = ToBeClassified;
        }
        field(200; "Pick No."; Code[20])
        {
            Caption = 'Pick No.';
            DataClassification = ToBeClassified;
        }
        field(210; "Registered Pick No."; Code[20])
        {
            Caption = 'Registered Pick No.';
            DataClassification = ToBeClassified;
        }
        field(300; "Shipment Method Code"; Code[20])
        {
            Caption = 'Shipment Method Code';
            DataClassification = ToBeClassified;
        }
        field(310; "Whse Shipment Created Date"; Date)
        {
            Caption = 'Whse Shipment Created Date';
            DataClassification = ToBeClassified;
        }
        field(500; "Next Shipment Date"; Date)
        {
            Caption = 'Next Shipment Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WarehouseRequest: Record "Warehouse Request";
            begin
                WarehouseRequest.Reset();
                WarehouseRequest.SetRange("Source Document", WarehouseRequest."Source Document"::"Sales Order");
                WarehouseRequest.SetRange("Source No.", rec."Sales Order No.");
                WarehouseRequest.SetRange("Completely Handled", FALSE);
                if WarehouseRequest.FindFirst() then begin
                    WarehouseRequest."Shipment Date" := "Next Shipment Date";
                    WarehouseRequest."Expected Shipment Date" := "Next Shipment Date";
                    WarehouseRequest.Modify();
                end;
            end;
        }
        field(510; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(515; "Available Quantity"; Decimal)
        {
            Caption = 'Available Quantity';
            DataClassification = ToBeClassified;
        }
        field(520; "Whse Quantity"; Decimal)
        {
            Caption = 'Whse Quantity';
            DataClassification = ToBeClassified;
        }
        field(530; "Remaining Qty to Ship"; Decimal)
        {
            Caption = 'Remaining Qty to Ship';
            DataClassification = ToBeClassified;
        }
        field(320; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = ToBeClassified;
        }
        field(330; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
        }
        field(600; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = "Not picked yet","Partially picked","Completely picked";
            DataClassification = ToBeClassified;
        }
        field(610; "Out of Stock"; boolean)
        {
            Caption = 'Out of Stock';
            DataClassification = ToBeClassified;
        }
        field(620; "Whse Shipment Created"; Boolean)
        {
            Caption = 'Pick Registered';
            DataClassification = ToBeClassified;
        }
        field(625; "Processed Shipment Date"; Date)
        {
            Caption = 'Processed Shipment Date';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
