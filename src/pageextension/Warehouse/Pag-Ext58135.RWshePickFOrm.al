pageextension 58135 "RWshePickFOrm" extends "Registered Pick Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }

    }
}
