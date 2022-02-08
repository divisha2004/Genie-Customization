/// <summary>
/// PageExtension PurchaseOrderSubformExt (ID 58104) extends Record Purchase Order Subform.
/// </summary>
pageextension 58104 "PurchaseOrderSubformExt" extends "Purchase Order Subform"
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
        modify("Item Reference No.")
        {
            Visible = true;
        }
    }
}
