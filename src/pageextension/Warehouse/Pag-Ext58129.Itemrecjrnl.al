pageextension 58129 "Itemrecjrnl" extends "Item Reclass. Journal"
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