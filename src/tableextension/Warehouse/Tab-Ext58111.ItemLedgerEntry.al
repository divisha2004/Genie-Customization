/// <summary>
/// TableExtension Tab-Ext58111.ItemLedgerEntry (ID 58111) extends Record Item Ledger Entry.
/// </summary>
tableextension 58111 "ItemLedgerEntry" extends "Item Ledger Entry"
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
