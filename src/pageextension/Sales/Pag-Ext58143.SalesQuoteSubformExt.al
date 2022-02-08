pageextension 58143 "SalesQuoteSubformExt" extends "Sales Quote Subform"
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
