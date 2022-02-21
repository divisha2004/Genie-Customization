/// <summary>
/// PageExtension PurchaseOrderSubformExt (ID 58104) extends Record Purchase Order Subform.
/// </summary>
pageextension 58104 "PurchaseOrderSubformExt" extends "Purchase Order Subform"
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
        modify("Item Reference No.")
        {
            Visible = true;
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
