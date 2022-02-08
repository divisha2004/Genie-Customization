pageextension 58151 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Order Reference Type"; Rec."Order Reference Type")
            {
                ApplicationArea = All;
            }
            field("Order Reference No."; Rec."Order Reference No.")
            {
                ApplicationArea = All;
            }
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
            }

        }
    }
}
