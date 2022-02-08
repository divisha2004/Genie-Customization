pageextension 58155 PurchaseOrderList extends "Purchase Order List"
{
    layout
    {
        addafter("No.")
        {
            field("Order Reference No."; Rec."Order Reference No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
