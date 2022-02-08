/// <summary>
/// TableExtension Wshejrnl (ID 58121) extends Record Warehouse Journal Line.
/// </summary>
tableextension 58121 "Wshejrnl" extends "Warehouse Journal Line"
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
