pageextension 58145 "ItemBinContentsExt" extends "Item Bin Contents"
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
        modify("Bin Code")
        {
            trigger OnAfterValidate()
            var
            begin
                rec.calcfields("Part No.")
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
            begin
                rec.calcfields("Part No.")
            end;
        }
    }
}
