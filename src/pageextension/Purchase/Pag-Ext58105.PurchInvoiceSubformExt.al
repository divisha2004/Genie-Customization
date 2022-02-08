/// <summary>
/// PageExtension PurchInvoiceSubformExt (ID 58105) extends Record Purch. Invoice Subform.
/// </summary>
pageextension 58105 "PurchInvoiceSubformExt" extends "Purch. Invoice Subform"
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
