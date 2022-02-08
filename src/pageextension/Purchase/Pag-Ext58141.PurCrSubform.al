pageextension 58141 "PurCrSubform" extends "Purch. Cr. Memo Subform"
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
