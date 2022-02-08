pageextension 58136 "PWsheShipmentLines" extends "Posted Whse. Shipment Lines"
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
