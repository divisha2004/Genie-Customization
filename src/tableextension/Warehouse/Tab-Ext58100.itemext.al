tableextension 58100 "itemext" extends Item
{

    fields
    {
        field(58100; "Part No."; Text[50])
        {

        }
        field(58110; "Sales Minimum Order Qty"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(58120; "Sales Multiplier"; Integer)
        {

        }
        field(58130; "Purchase Minimum Order Qty"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(58140; "Purchase Multiplier"; Integer)
        {

        }
    }
    keys
    {
        key(PartNo; "Part No.")
        {

        }
    }
    fieldgroups
    {
        addlast(DropDown; "Part No.", "Description 2")
        {

        }
    }




}