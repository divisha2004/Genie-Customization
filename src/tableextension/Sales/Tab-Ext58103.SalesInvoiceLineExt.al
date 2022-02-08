tableextension 58103 "SalesInvoiceLineExt" extends "Sales Invoice Line"
{
    fields
    {
        field(58100; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;
        }
    }
}
