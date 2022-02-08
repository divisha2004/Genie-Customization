pageextension 58130 "PWsheRcptLine" extends "Posted Whse. Receipt Subform"
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
