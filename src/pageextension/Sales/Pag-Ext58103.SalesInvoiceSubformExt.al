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
    trigger OnModifyRecord(): Boolean
    var
        ItemVariant: Record "Item Variant";
    begin
        if Rec.Type <> Rec.type::Item then
            exit;
        if rec."No." = '' then
            exit;
        if Rec."Variant Code" <> '' then
            exit;
        ItemVariant.reset;
        ItemVariant.SetRange("Item No.", rec."No.");
        if ItemVariant.FindSet() then
            Message(StrSubstNo('Please select the Item Variant for the Item %1', rec."No."));
    end;
}
