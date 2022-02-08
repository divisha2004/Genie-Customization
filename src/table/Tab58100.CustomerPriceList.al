/// <summary>
/// Table Customer Price List (ID 58100).
/// </summary>
table 58100 "Customer Price List"
{
    Caption = 'Customer Price List';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
            begin
                rec.CalcFields("Customer Price List Type");
            end;
        }
        field(20; "Price List Code"; Code[20])
        {
            Caption = 'Price List Code';
            DataClassification = ToBeClassified;
            TableRelation = "Price List Header"."Code" where("Customer Price List Type" = field("Customer Price List Type"));
            NotBlank = true;
        }
        field(30; "Price List Description"; Text[250])
        {
            Caption = 'Price List Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Price List Header".Description where("Code" = field("Price List Code")));
            Editable = false;
        }
        field(50; "Customer Price List Type"; Enum "Customer Price List Type")
        {
            Caption = 'Customer Price List Type';
            FieldClass = FlowField;
            CalcFormula = lookup(customer."Customer Price List Type" where("No." = field("Customer No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Price List Code")
        {
            Clustered = true;
        }
    }

}
