/// <summary>
/// PageExtension PostedPurchRcptSubformExt (ID 58109) extends Record Posted Purchase Rcpt. Subform.
/// </summary>
pageextension 58109 "PostedPurchRcptSubformExt" extends "Posted Purchase Rcpt. Subform"
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
