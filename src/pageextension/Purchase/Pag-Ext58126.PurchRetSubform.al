pageextension 58126 "PurchRetSubform" extends "Purchase Return Order Subform"
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
