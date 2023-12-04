table 50103 "Complaint Result"
{
    Caption = 'Complaint Result';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;

        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Text[100])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(5; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(6; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(7; "ItemLedgerEntryNo"; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            DataClassification = CustomerContent;
        }
        field(8; "Customer No."; Text[100])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

        }
        field(9; "Quantity"; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;


        }
        field(10; "Return Quantity"; Integer)
        {
            Caption = 'Return Quantity';
            DataClassification = CustomerContent;

        }
        field(11; ShipmentDate; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Original Order No."; Code[20])
        {
            Caption = 'Original Order No.';
            DataClassification = ToBeClassified;
        }
        field(13; "Original Line No."; Integer)
        {
            Caption = 'Original Line No.';
            DataClassification = ToBeClassified;
        }
        field(14; "Gen. Bus. Posting Group"; Text[100])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }

}