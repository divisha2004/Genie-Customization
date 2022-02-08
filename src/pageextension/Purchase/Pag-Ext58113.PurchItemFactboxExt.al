/// <summary>
/// PageExtension PurchItemFactboxExt (ID 58113) extends Record Item Replenishment FactBox.
/// </summary>
pageextension 58113 "PurchItemFactboxExt" extends "Item Replenishment FactBox"
{
    layout
    {
        addafter("No.")
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
}
