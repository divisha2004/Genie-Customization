/// <summary>
/// PageExtension CustDetailsFactboxExt (ID 58117) extends Record Customer Details FactBox.
/// </summary>
pageextension 58117 "CustDetailsFactboxExt" extends "Customer Details FactBox"
{
    layout
    {
        addafter(Contact)
        {
            field("Customer Price List Type98300"; Rec."Customer Price List Type")
            {
                ApplicationArea = All;
            }
        }
    }
}