pageextension 58159 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Invoice Only"; Rec."Invoice Only")
            {
                ApplicationArea = All;
                Style = Favorable;
            }
        }

    }
}
