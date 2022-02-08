pageextension 58146 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Double Blind Shipment"; Rec."Double Blind Shipment")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
            field("Expected Shipment Date"; Rec."Expected Shipment Date")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }

    }
    actions
    {
        addafter("Print Confirmation")
        {
            group(DoubleBlind)
            {
                Caption = 'Double Blind Shipment';
                action(PrintBlindShipOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Order Acknowledgement Double Blind Shipment';
                    Promoted = true;
                    PromotedCategory = Report;
                    Image = PrintAcknowledgement;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        CurrPage.SetSelectionFilter(SalesHeader);
                        Report.RunModal(58101, true, true, SalesHeader);
                    end;
                }
            }
        }
    }
}
