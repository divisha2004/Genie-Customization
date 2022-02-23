pageextension 58158 SalesOrderList extends "Sales Order List"
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
            field("Next Shipment Date"; Rec."Next Shipment Date")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }
    }
}
