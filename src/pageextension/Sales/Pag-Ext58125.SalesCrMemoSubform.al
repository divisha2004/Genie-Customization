pageextension 58125 "SalesCrMemoSubform" extends "Sales Cr. Memo Subform"
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
