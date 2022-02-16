pageextension 58160 ReqWkshName extends "Req. Wksh. Names"
{
    layout
    {
        addafter(Description)
        {
            field("Automate Get Sales Order"; Rec."Automate Get Sales Order")
            {
                ApplicationArea = All;
            }

        }
    }
}
