pageextension 58150 CustomerLedgerEntry extends "Customer Ledger Entries"
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
