/// <summary>
/// TableExtension Tab-Ext58112-WhseShipmentLine (ID 58113) extends Record Warehouse Shipment Line.
/// </summary>
tableextension 58113 "WhseShipmentLine" extends "Warehouse Shipment Line"
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
