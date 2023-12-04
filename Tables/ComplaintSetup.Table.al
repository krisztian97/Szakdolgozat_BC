table 50102 ComplaintSetup
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; ReturnOrder; Code[20])
        {
            Caption = 'Order Type Return Order';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason".Code;
        }
        field(3; RepairOrder; Code[20])
        {
            Caption = 'Order Type Repair Order';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason".Code;
        }
        field(4; ReplacementOrder; Code[20])
        {
            Caption = 'Order Type Replacement Order';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason".Code;
        }
        field(5; TransportDamage; Code[20])
        {
            Caption = 'Order Type Transport Damage';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason".Code;
        }
        field(6; Loss; Code[20])
        {
            Caption = 'Order Type Loss';
            DataClassification = ToBeClassified;
            TableRelation = "Return Reason".Code;
        }
        field(7; ItemCharges; Code[20])
        {
            Caption = 'Item Charges';
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge"."No.";
        }
        field(8; AutoCreateCreditMemo; Boolean)
        {
            Caption = 'Create Credit Memo';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}