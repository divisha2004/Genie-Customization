page 58101 "Automate Whse Log Entries"
{
    ApplicationArea = All;
    Caption = 'Automate Whse Log Entries';
    PageType = List;
    SourceTable = "Auto Whse. Ship Log Entries";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order No. field.';
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Sales Order Line No. field.';
                    ApplicationArea = All;
                }
                field("Whse Shipment No."; Rec."Whse Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Whse Shipment No. field.';
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ToolTip = 'Specifies the value of the Part No. field.';
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                    ApplicationArea = All;
                }
                field("Next Shipment Date"; Rec."Next Shipment Date")
                {
                    ToolTip = 'Specifies the value of the Next Shipment Date field.';
                    ApplicationArea = All;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ToolTip = 'Specifies the value of the Order Quantity field.';
                    ApplicationArea = All;
                }
                field("Available Quantity"; Rec."Available Quantity")
                {
                    ToolTip = 'Specifies the value of the Available Quantity field.';
                    ApplicationArea = All;
                }
                field("Out of Stock"; Rec."Out of Stock")
                {
                    ToolTip = 'Specifies the value of the Out of Stock field.';
                    ApplicationArea = All;
                }

                field("Registered Pick No."; Rec."Registered Pick No.")
                {
                    ToolTip = 'Specifies the value of the Registered Pick No. field.';
                    ApplicationArea = All;
                }
                field("Remaining Qty to Ship"; Rec."Remaining Qty to Ship")
                {
                    ToolTip = 'Specifies the value of the Remaining Qty to Ship field.';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.';
                    ApplicationArea = All;
                }
                field("Whse Quantity"; Rec."Whse Quantity")
                {
                    ToolTip = 'Specifies the value of the Whse Quantity field.';
                    ApplicationArea = All;
                }
                field("Whse Shipment Created Date"; Rec."Whse Shipment Created Date")
                {
                    ToolTip = 'Specifies the value of the Whse Shipment Created Date field.';
                    ApplicationArea = All;
                }

            }
        }
    }
}
