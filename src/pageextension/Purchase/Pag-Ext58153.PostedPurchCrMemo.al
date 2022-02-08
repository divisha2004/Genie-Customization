pageextension 58153 PostedPurchCrMemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
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
