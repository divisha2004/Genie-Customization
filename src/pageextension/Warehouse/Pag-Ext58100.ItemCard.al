/// <summary>
/// PageExtension ItemCard (ID 58100) extends Record Item Card.
/// </summary>
pageextension 58100 "ItemCard" extends "Item Card"
{
    layout
    {
        addafter("No.")
        {

            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }
        addafter("Part No.")
        {
            field("Manufacturer Code"; rEC."Manufacturer Code")
            {
                ApplicationArea = All;
            }

        }
        addafter("Description")
        {
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }
        }
        addafter("Sales Unit of Measure")
        {
            field("Sales Minimum Order Qty"; Rec."Sales Minimum Order Qty")
            {
                ApplicationArea = All;
            }
            field("Sales Multiplier"; Rec."Sales Multiplier")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purch. Unit of Measure")
        {
            field("Purchase Minimum Order Qty"; Rec."Purchase Minimum Order Qty")
            {
                ApplicationArea = All;
            }
            field("Purchase Multiplier"; Rec."Purchase Multiplier")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}