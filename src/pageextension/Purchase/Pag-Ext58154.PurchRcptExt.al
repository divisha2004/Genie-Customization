pageextension 58154 PurchRcptExt extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("Order Reference Type"; Rec."Order Reference Type")
            {
                ApplicationArea = All;
                Editable = FALSE;
            }
            field("Order Reference No."; Rec."Order Reference No.")
            {
                ApplicationArea = All;
                Editable = FALSE;
            }
            field("Customer PO No."; Rec."Customer PO No.")
            {
                ApplicationArea = All;
                Editable = FALSE;
            }

        }
    }
}
