pageextension 50102 "Sales Return Order Extension" extends "Sales Return Order"
{
    layout
    {
        addafter(Status)
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = all;
                Caption = 'Order Type';
            }
        }
    }

    actions
    {

    }
}
