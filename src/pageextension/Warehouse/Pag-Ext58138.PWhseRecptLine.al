pageextension 58138 "PWhseRecptLine" extends "Posted Whse. Receipt Lines"
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
