tableextension 50107 "Sales Line Extension" extends "Sales Line"
{
    fields
    {
        field(50101; "Original Order No."; Code[20])
        {
            Caption = 'Original Order No.';
            DataClassification = ToBeClassified;
        }
    }
}
