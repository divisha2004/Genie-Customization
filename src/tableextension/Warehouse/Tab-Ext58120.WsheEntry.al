/// <summary>
/// TableExtension WsheEntry (ID 58120) extends Record Warehouse Entry.
/// </summary>
tableextension 58120 "WsheEntry" extends "Warehouse Entry"
{
    fields
    {
        field(58100; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                LItem: Record "Item";
            begin
                LItem.RESET;
                if Page.RunModal(pAGE::"Item List", LItem) = Action::LookupOK then begin
                    Rec.Validate("Item No.", LItem."No.");
                    "Part No." := LItem."Part No.";
                end;
            end;
        }
    }

}
