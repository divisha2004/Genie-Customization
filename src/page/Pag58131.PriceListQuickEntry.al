page 58131 "Price List Quick Entry"
{
    ApplicationArea = All;
    Caption = 'Price List Quick Update';
    PageType = List;
    SourceTable = "Price List Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Price List Code"; Rec."Price List Code")
                {
                    ToolTip = 'Specifies the value of the Price List Code field.';
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                    ApplicationArea = All;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ToolTip = 'Specifies the value of the Product No. (Item No.) field.';
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ToolTip = 'Specifies the value of the Part No. filed';
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the value of the Minimum Quantity field.';
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.';
                    ApplicationArea = All;
                }
                field("Price Type"; Rec."Price Type")
                {
                    ToolTip = 'Specifies the value of the Price Type field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
