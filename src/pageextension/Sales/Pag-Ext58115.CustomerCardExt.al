/// <summary>
/// PageExtension CustomerCardExt (ID 58115) extends Record Customer Card.
/// </summary>
pageextension 58115 "CustomerCardExt" extends "Customer Card"
{
    layout
    {
        addafter("Customer Price Group")
        {
            field("Customer Price List Type"; Rec."Customer Price List Type")
            {
                ApplicationArea = All;
            }
            field("Shipment Day"; Rec."Shipment Day")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Customer")
        {
            action(CustomerPriceList)
            {
                ApplicationArea = All;
                Caption = 'Customer Price List';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Price;
                RunObject = page CustomerPriceList;
                RunPageLink = "Customer No." = field("No.");
                RunPageMode = Edit;
            }
        }
    }
}
