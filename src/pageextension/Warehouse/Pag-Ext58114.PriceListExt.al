/// <summary>
/// PageExtension PriceListExt (ID 58114) extends Record Sales Price List.
/// </summary>
pageextension 58114 "PriceListExt" extends "Sales Price List"
{
    layout
    {
        addafter(EndingDate)
        {
            field("Customer Price List Type"; Rec."Customer Price List Type")
            {
                ApplicationArea = All;
            }
            field("Is FLIR CC Price List"; Rec."Is FLIR Price List")
            {
                ApplicationArea = All;
            }
        }
    }
}
