tableextension 58125 "BinContentExt" extends "Bin Content"
{
    fields
    {
        field(58100; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Part No." where("No." = field("Item No.")));
        }
    }
}
