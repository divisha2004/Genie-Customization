pageextension 58157 ShipmentMethod extends "Shipment Methods"
{
    layout
    {
        addafter(Description)
        {
            field("Shipment Day"; Rec."Shipment Day")
            {
                ApplicationArea = All;
            }
        }
    }
}
