pageextension 58131 "PWsheShipmentLine" extends "Posted Whse. Shipment Subform"
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
