/// <summary>
/// TableExtension ItemJrnllineext (ID 58117) extends Record Item Journal Line.
/// </summary>
tableextension 58117 "ItemJrnllineext" extends "Item Journal Line"
{
    fields
    {
        field(58100; "Part No."; Text[50])
        {
            Caption = 'Part No.';
            DataClassification = ToBeClassified;

            TableRelation = Item."Part No." WHERE(Blocked = CONST(false),
                                                    "Sales Blocked" = CONST(false));

            // trigger OnLookup()
            // begin
            //     IF rec.Type <> rec.Type::Item then
            //         exit;
            //     LItem.RESET;
            //     if Page.RunModal(pAGE::"Item List", LItem) = Action::LookupOK then begin
            //         Rec.Validate("No.", LItem."No.");
            //         "Part No." := LItem."Part No.";
            //     end;
            // end;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
            begin
                if Rec."Part No." <> '' THEN BEGIN
                    // looking for an item with exact description
                    LItem.Reset();
                    LItem.SetCurrentKey("Part No.");
                    LItem.SetRange("Part No.", REC."Part No.");
                    IF LItem.FindFirst() then begin
                        REC.Validate("No.", LItem."No.");
                        exit;
                    end;
                    // looking for an item with similar description
                    LItem.reset();
                    LItem.SetCurrentKey("Part No.");
                    LItem.SetFilter("Part No.", '''@' + ConvertStr(Rec."Part No.", '''', '?') + '''');
                    if LItem.FindFirst() then begin
                        rec.Validate("No.", LItem."No.");
                        exit;
                    end;
                    LItem.RESET;
                    if Page.RunModal(pAGE::"Item List", LItem) = Action::LookupOK then begin
                        Rec.Validate("No.", LItem."No.");
                        "Part No." := LItem."Part No.";
                    end;
                END;
            end;
        }

    }
    VAR
        LItem: Record "Item";
}
