pageextension 58157 PackLineBuffer extends "DSHIP Package Worksheet"

{
    layout
    {
        addbefore("Item No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }
        }

        modify(edtScan)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if rec.FindSet() then begin
                    repeat
                        item.get(rec."Item No.");
                        rec."Part No." := item."Part No.";
                        rec.Modify();
                    until rec.Next() = 0;
                end;
            end;
        }

    }

    trigger OnOpenPage()
    var
        Item: Record Item;
    begin
        if rec.FindSet() then begin
            repeat
                item.get(rec."Item No.");
                rec."Part No." := item."Part No.";
                rec.Modify();
            until rec.Next() = 0;
        end;
    end;




    var
        myInt: Integer;
}
