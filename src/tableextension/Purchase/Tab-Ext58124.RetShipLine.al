/// <summary>
/// TableExtension "RetShipLine" (ID 58124) extends Record Return Shipment Line.
/// </summary>
tableextension 58124 RetShipLine extends "Return Shipment Line"
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
                    Rec.Validate("No.", LItem."No.");
                    "Part No." := LItem."Part No.";
                end;
            end;
        }
    }
}
