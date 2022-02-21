/// <summary>
/// PageExtension "PageExtension50004" (ID 58142) extends Record Req. Worksheet.
/// </summary>
pageextension 58142 "ReqWorksheetExt" extends "Req. Worksheet"
{
    layout
    {
        addafter(Type)
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = All;
            }
        }
    }

}
