/// <summary>
/// PageExtension PostedSalesInvSubformExt (ID 58106) extends Record Posted Sales Invoice Subform.
/// </summary>
pageextension 58106 "PostedSalesInvSubformExt" extends "Posted Sales Invoice Subform"
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
