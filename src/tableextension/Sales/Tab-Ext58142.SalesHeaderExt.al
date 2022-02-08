/// <summary>
/// TableExtension "SalesHeaderExt" (ID 58142) extends Record Sales Header.
/// </summary>
tableextension 58142 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(58100; "Double Blind Shipment"; Boolean)
        {
            Caption = 'Double Blind Shipment';
            DataClassification = ToBeClassified;
        }
        field(58110; "Expected Shipment Date"; Date)
        {
            Caption = 'Expected Shipment Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        modify("External Document No.")
        {
            Caption = 'Customer PO No.';
        }
    }
}

