pageextension 58127 "PurchCrdSubform" extends "Posted Purchase Cr. Memo Lines"
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
