reportextension 58102 "SalesShipmentExt" extends "Sales Shipment NA"
{
    dataset
    {
        add("Sales Shipment Line")
        {
            column(PartNo; "Sales Shipment Line"."Part No.")
            {

            }
            column(NewDescriptionlbl; 'Part No / Description')
            {

            }
        }
    }
    var
        NewDescriptionlbl: Text[100];

}
