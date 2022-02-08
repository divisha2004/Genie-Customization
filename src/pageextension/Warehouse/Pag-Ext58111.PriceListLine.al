/// <summary>
/// PageExtension PriceListLine (ID 58111) extends Record Price List Lines.
/// </summary>
pageextension 58111 "PriceListLine" extends "Price List Lines"
{

    layout
    {

        addafter("Asset Type")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Minimum Quantity")
        {
            field("Manufacturer Code "; Rec."Manufacturer Code ")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(OpenPage)
            {
                ApplicationArea = All;
                Caption = 'Price List Quick Update', comment = 'NLB="Open the Price List Quick Entry form"';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                //  RunObject = Page "Sales Price Quick Entry";
                //  RunPageLink = "Price List COde" = FIELD("Price List Code");
                ToolTip = 'Edit the Price List.';

                trigger OnAction()
                var
                    SalPriceQEn: Page "Price List Quick Entry";
                    Pricelistline: Record "Price List Line";
                begin
                    if rec.Status = rec.Status::Active then
                        Error('Set Status to Draft to use this feature');

                    Pricelistline.Reset();
                    Pricelistline.SetRange("Price List Code", rec."Price List Code");
                    SalPriceQEn.SetTableView(Pricelistline);
                    SalPriceQEn.Run();

                end;
            }
        }
    }
}
