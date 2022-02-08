pageextension 58120 "WsheShipmentLine" extends "Whse. Shipment Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }

    }
}
