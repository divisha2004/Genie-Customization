pageextension 58123 "WhsePickLine" extends "Whse. Pick Subform"
{

    layout
    {
        addafter("Item No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }
    }
}
