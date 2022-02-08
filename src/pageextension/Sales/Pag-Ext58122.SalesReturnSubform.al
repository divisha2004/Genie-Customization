pageextension 58122 "SalesReturnSubform" extends "Sales Return Order Subform"
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
