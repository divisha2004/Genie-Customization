pageextension 58156 PurchaseInvoiceList extends "Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {
            field("Order Reference No."; Rec."Order Reference No.")
            {
                ApplicationArea = All;
            }
            field("Invoice Only"; Rec."Invoice Only")
            {
                ApplicationArea = All;
            }

        }
    }
}
