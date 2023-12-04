pageextension 50101 "Sales Order Subform Extension" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line No.")
        {
            field("Original Order No."; Rec."Original Order No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }
}
