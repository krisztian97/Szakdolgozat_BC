tableextension 50108 "Item Journal Line Extension" extends "Item Journal Line"
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
