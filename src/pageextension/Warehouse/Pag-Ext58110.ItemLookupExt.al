/// <summary>
/// PageExtension ItemLookupExt (ID 58110) extends Record Item Lookup.
/// </summary>
pageextension 58110 "ItemLookupExt" extends "Item Lookup"
{
    layout
    {
        addafter("No.")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = all;
            }
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }
        }
    }
}
