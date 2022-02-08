pageextension 58124 "SalesCrMemoLine" extends "Posted Sales Cr. Memo Subform"
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
