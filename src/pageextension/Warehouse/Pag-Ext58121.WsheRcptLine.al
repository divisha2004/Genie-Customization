pageextension 58121 "WsheRcptLine" extends "Whse. Receipt Subform"
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
