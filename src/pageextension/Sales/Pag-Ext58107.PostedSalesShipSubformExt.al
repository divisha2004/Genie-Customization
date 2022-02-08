/// <summary>
/// PageExtension PostedSalesShipSubformExt (ID 58107) extends Record Posted Sales Shpt. Subform.
/// </summary>
pageextension 58107 "PostedSalesShipSubformExt" extends "Posted Sales Shpt. Subform"
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

    }
}
