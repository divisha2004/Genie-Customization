pageextension 58144 "BinContents" extends "Bin Contents"
{
    layout
    {
        addafter("Bin Code")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
