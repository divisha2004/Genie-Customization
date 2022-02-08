/// <summary>
/// PageExtension "PurchaseOrderExt" (ID 58116) extends Record Purchase Order.
/// </summary>
pageextension 58116 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        modify(Control1903326807)
        {
            Visible = true;
        }
        addafter("Vendor Invoice No.")
        {
            field("Order Reference Type"; Rec."Order Reference Type")
            {
                ApplicationArea = All;
            }
            field("Order Reference No."; Rec."Order Reference No.")
            {
                ApplicationArea = All;
            }
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
            }

        }
    }

}