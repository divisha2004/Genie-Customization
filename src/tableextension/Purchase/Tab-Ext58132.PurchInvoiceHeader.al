tableextension 58132 PurchInvoiceHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(58100; "Order Reference Type"; Enum "Sales Document Type")
        {
            Caption = 'Order Reference Type';
            DataClassification = ToBeClassified;
        }
        field(58101; "Order Reference No."; Code[20])
        {
            Caption = 'Order Reference No.';
            DataClassification = ToBeClassified;
        }
        field(58102; "Customer PO No."; Code[35])
        {
            Caption = 'Customer PO No.';
            DataClassification = ToBeClassified;
        }
        field(58120; "Invoice Only"; Boolean)
        {
            Caption = 'Invoice Only';
            DataClassification = ToBeClassified;

        }
    }
}
