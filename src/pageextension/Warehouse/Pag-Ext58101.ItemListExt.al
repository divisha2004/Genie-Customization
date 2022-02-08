/// <summary>
/// PageExtension ItemListExt (ID 58101) extends Record Item List.
/// </summary>
pageextension 58101 "ItemListExt" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = all;
            }
            field("Manufacturer Code"; rec."Manufacturer Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Description")
        {
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }
        }
    }
}
