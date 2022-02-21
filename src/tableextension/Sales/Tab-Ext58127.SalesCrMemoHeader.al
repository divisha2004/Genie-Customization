tableextension 58127 "SalesCrMemoHeader" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(58100; "Double Blind Shipment"; Boolean)
        {
            Caption = 'Blind Shipment';
            DataClassification = ToBeClassified;
        }
        field(58110; "Expected Shipment Date"; Date)
        {
            Caption = 'Expected Shipment Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58120; "Invoice Only"; Boolean)
        {
            Caption = 'Invoice Only';
            DataClassification = ToBeClassified;
        }

    }
}
