pageextension 58147 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Double Blind Shipment"; Rec."Double Blind Shipment")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }

    }
}
