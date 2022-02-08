/// <summary>
/// PageExtension "PurchasePrriceList" (ID 58118) extends Record Purchase Price List Lines.
/// </summary>
pageextension 58118 PurchasePrriceList extends "Purchase Price List Lines"
{
    layout
    {
        addafter("Asset Type")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = All;
            }

        }
        addafter("Minimum Quantity")
        {
            field("Manufacturer Code "; rec."Manufacturer Code ")
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
                ToolTip = 'Edit the Price List.';

                trigger OnAction()
                var
                    PurPriceQEn: Page "Price List Quick Entry";
                    Pricelistline: Record "Price List Line";
                begin
                    if rec.Status = rec.Status::Active then
                        Error('Set Status to Draft to use this feature');

                    Pricelistline.Reset();
                    Pricelistline.SetRange("Price List Code", rec."Price List Code");
                    PurPriceQEn.SetTableView(Pricelistline);
                    PurPriceQEn.Run();

                end;
            }
        }
    }
}