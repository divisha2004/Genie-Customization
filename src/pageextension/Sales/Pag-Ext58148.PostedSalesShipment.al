pageextension 58148 PostedSalesShipment extends "Posted Sales Shipment"
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
