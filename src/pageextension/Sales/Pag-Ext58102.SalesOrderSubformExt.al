/// <summary>
/// PageExtension SalesOrderSubformExt (ID 58102) extends Record Sales Order Subform.
/// </summary>
pageextension 58102 "SalesOrderSubformExt" extends "Sales Order Subform"
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
