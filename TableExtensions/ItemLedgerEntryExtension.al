tableextension 50106 "Item Ledger Entry Extension" extends "Item Ledger Entry"
{
    fields
    {
        field(50101; "Original Order No."; Code[20])
        {
            Caption = 'Original Order No.';
            DataClassification = ToBeClassified;
        }
        field(50102; "Original Order Line No. "; Integer)
        {
            Caption = 'Original Order Line No. ';
            DataClassification = ToBeClassified;
        }
    }
}
