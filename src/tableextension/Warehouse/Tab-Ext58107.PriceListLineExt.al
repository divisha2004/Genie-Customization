/// <summary>
/// TableExtension PriceListLineExt (ID 58107) extends Record Price List Line.
/// </summary>
tableextension 58107 "PriceListLineExt" extends "Price List Line"
{
    fields
    {
        field(58100; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                LItem: Record Item;
            begin
                IF rec."Asset Type" <> rec."Asset Type"::Item then
                    exit;
                LItem.RESET;
                if Page.RunModal(pAGE::"Item List", LItem) = Action::LookupOK then begin
                    Rec.Validate("Asset No.", LItem."No.");
                    Rec."Part No." := LItem."Part No.";
                    rec."Manufacturer Code " := LItem."Manufacturer Code";
                end;
            end;
        }
        modify("Asset No.")
        {
            trigger OnAfterValidate()
            var
                LItem: Record Item;
            begin
                IF rec."Asset Type" <> rec."Asset Type"::Item then
                    exit;
                if "Asset No." <> '' THEN begin
                    LItem.Get("Asset No.");
                    Rec."Part No." := LItem."Part No.";
                    rec."Manufacturer Code " := LItem."Manufacturer Code";
                    if rec.Modify then;
                end;
            end;
        }
        field(58101; "Manufacturer Code "; Code[20])
        {
            Caption = 'Manufacturer Code ';
            DataClassification = ToBeClassified;
            TableRelation = Manufacturer;
        }
    }
    trigger OnAfterModify()
    var
        Item: Record Item;
    begin
        if ("Asset Type" = "Asset Type"::Item) AND ("Asset No." <> '') then begin
            PriceListHeader.Get("Price List Code");
            Item.get("Asset No.");
            "Part No." := item."Part No.";
            "Manufacturer Code " := Item."Manufacturer Code";
            "Source Type" := PriceListHeader."Source Type";
            "Source No." := PriceListHeader."Source No.";
            rec.Modify();
        end;
    end;
}
