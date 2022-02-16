/// <summary>
/// PageExtension "PageExtension50004" (ID 58142) extends Record Req. Worksheet.
/// </summary>
pageextension 58142 "ReqWorksheetExt" extends "Req. Worksheet"
{
    layout
    {
        addafter(Type)
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Part No."; Rec."Part No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    var
        ReqWhseName: Record "Requisition Wksh. Name";
        GetSalesOrder: Report "Get Sales Orders";
    begin
        ReqWhseName.reset;
        ReqWhseName.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
        ReqWhseName.SetRange(Name, rec."Journal Batch Name");
        if ReqWhseName.FindFirst() THEN
            IF ReqWhseName."Automate Get Sales Order" then begin
                GetSalesOrder.SetReqWkshLine(Rec, 0);
                GetSalesOrder.UseRequestPage(false);
                GetSalesOrder.Run;
                Clear(GetSalesOrder);
            end;

    end;
}
