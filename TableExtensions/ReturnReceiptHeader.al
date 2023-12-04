tableextension 50105 "Return R. Header Extension" extends "Return Receipt Header"
{
    fields
    {
        field(50101; "Original Order No."; Code[20])
        {
            Caption = 'Original Order No.';
            DataClassification = ToBeClassified;
        }
        field(50102; "Order Type"; Code[20])
        {
            Caption = 'Order Type';
            DataClassification = ToBeClassified;
        }
        field(50103; "Replacement Order No"; Code[20])
        {
            Caption = 'Replacement Order No';
            DataClassification = ToBeClassified;
        }
    }
}
