/// <summary>
/// PageExtension ItemFactboxExt (ID 58112) extends Record Item Invoicing FactBox.
/// </summary>
pageextension 58112 "ItemFactboxExt" extends "Item Invoicing FactBox"
{
    layout
    {
        addafter("No.")
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
    }
}
