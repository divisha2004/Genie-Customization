/// <summary>
/// TableExtension "SalesHeaderExt" (ID 58142) extends Record Sales Header.
/// </summary>
tableextension 58142 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(58100; "Double Blind Shipment"; Boolean)
        {
            Caption = 'Blind Shipment';
            DataClassification = ToBeClassified;
        }
        field(58110; "Expected Shipment Date"; Date)
        {
            Caption = 'Expected Shipment Date';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(58120; "Invoice Only"; Boolean)
        {
            Caption = 'Invoice Only';
            DataClassification = ToBeClassified;
        }

        field(58130; "Shipment Day"; Enum "Shipment Day")
        {
            Caption = 'Shipment Day';
            DataClassification = ToBeClassified;
        }

        field(58150; "Next Shipment Date"; Date)
        {
            Caption = 'Next Shipment Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Request"."Shipment Date" where("Source No." = field("No."),
                                                                           "Source Document" = filter("Sales Order"),
                                                                           "Completely Handled" = filter(false)));
        }

        modify("External Document No.")
        {
            Caption = 'Customer PO No.';
        }


    }
}

