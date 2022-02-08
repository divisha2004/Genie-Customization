/// <summary>
/// PageExtension SalesInvoiceSubformExt (ID 58103) extends Record Sales Invoice Subform.
/// </summary>
pageextension 58103 "SalesInvoiceSubformExt" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }

    }
}
