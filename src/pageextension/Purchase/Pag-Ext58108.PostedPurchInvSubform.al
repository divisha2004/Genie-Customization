/// <summary>
/// PageExtension PostedPurchInvSubform (ID 58108) extends Record Posted Purch. Invoice Subform.
/// </summary>
pageextension 58108 "PostedPurchInvSubform" extends "Posted Purch. Invoice Subform"
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
