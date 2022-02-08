reportextension 58101 "SalesOrderConfirmationExt" extends "Standard Sales - Order Conf."
{

    dataset
    {

        add(Line)
        {
            column(PartNo; Line."Part No.")
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

