pageextension 58134 "RWsheAvtyLine" extends "Registered Whse. Act.-Lines"
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
