tableextension 58108 "PriceListHeaderExt" extends "Price List Header"
{
    fields
    {
        field(58100; "Customer Price List Type"; Enum "Customer Price List Type")
        {
            Caption = 'Customer Price List Type';
            DataClassification = ToBeClassified;
        }
        field(58110; "Is FLIR Price List"; Boolean)
        {
            Caption = 'Is FLIR CC Price List';
            DataClassification = ToBeClassified;
        }
    }
}
