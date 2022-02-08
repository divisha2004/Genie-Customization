/// <summary>
/// Page CustomerPriceList (ID 58130).
/// </summary>
page 58130 "CustomerPriceList"
{

    ApplicationArea = All;
    Caption = 'CustomerPriceList';
    PageType = List;
    SourceTable = "Customer Price List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Price List Code"; Rec."Price List Code")
                {
                    ToolTip = 'Specifies the value of the Price List Code field.';
                    ApplicationArea = All;

                }
                field("Price List Description"; Rec."Price List Description")
                {
                    ApplicationArea = All;
                }
                field("Customer Price List Type"; Rec."Customer Price List Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
        }
    }
    trigger OnOpenPage()
    var

    begin
        Rec.CalcFields("Customer Price List Type")
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("Customer Price List Type")
    end;

    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        rec.CalcFields("Customer Price List Type")
    end;
}
