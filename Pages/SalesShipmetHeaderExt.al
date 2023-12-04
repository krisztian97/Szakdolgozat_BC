tableextension 50102 "Sales S. Header Extension" extends "Sales Shipment Header"
{
    fields
    {
        field(50101; "Original Order No."; Code[20])
        {
            Caption = 'Originial Order No.';
            DataClassification = ToBeClassified;
        }
    }
}
