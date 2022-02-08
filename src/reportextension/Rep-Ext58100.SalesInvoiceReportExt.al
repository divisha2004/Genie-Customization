reportextension 58100 "SalesInvoiceReportExt" extends "Standard Sales - Invoice"
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

