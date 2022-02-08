tableextension 58136 ShipmentMethod extends "Shipment Method"
{
    fields
    {
        field(58100; "Shipment Day"; Option)
        {
            Caption = 'Shipment Day';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Monday","Tuesday","Wednesday","Thursday","Friday","Any Day";
        }
    }
}
