tableextension 58110 "Price Asset Ext" extends "Price Asset"
{
    fields
    {
        field(58100; "Part No."; Text[50])

        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
        field(58101; "Manufacturer Code "; Code[20])
        {
            Caption = 'Manufacture Code';
            DataClassification = ToBeClassified;
            TableRelation = Manufacturer;
        }
    }
}
