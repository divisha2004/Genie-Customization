tableextension 58109 "CustomerExt" extends Customer
{
    fields
    {
        field(58100; "Customer Price List Type"; Enum "Customer Price List Type")
        {
            Caption = 'Customer Price List Type';
            DataClassification = ToBeClassified;
        }

        field(58110; "Shipment Day"; Enum "Shipment Day")
        {
            Caption = 'Shipment Day';
            DataClassification = ToBeClassified;

        }
    }
}
