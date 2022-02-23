pageextension 58146 SalesOrder extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Shipment Day"; rec."Shipment Day")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
            field("Blind Shipment"; Rec."Double Blind Shipment")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
            field("Expected Shipment Date"; Rec."Shipment Date")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
            field("Next Shipment Date"; Rec."Next Shipment Date")
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
                Caption = 'Blind Shipment';
                action(PrintBlindShipOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Blind Shipment (Ack)';
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
            group(NormalShipment)
            {
                Caption = 'Normal Shipment';
                action(PrintNormalShip)
                {
                    ApplicationArea = All;
                    Caption = 'Normal Shipment (Ack)';
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;
                    Image = Print;
                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        CurrPage.SetSelectionFilter(SalesHeader);
                        Report.RunModal(58102, true, true, SalesHeader);
                    end;
                }
            }
            action(RunOrderFulFilment)
            {
                ApplicationArea = All;
                Caption = 'Process Order Fulfilment';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                Visible = true;
                trigger OnAction()
                var
                    OrderfulfilMgmt: codeunit "Order fulfilment Management";

                begin
                    Clear(OrderfulfilMgmt);
                    OrderfulfilMgmt.ProcessWhseRequest();
                end;
            }
            action(ShowWhseLogEntries)
            {
                ApplicationArea = All;
                Caption = 'Automate Warehouse log Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                Visible = true;
                trigger OnAction()
                var

                begin
                    page.RunModal(58101);
                end;
            }
        }
    }
}
