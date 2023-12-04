pageextension 50100 "Item Ledger Entries Extension" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Original Order No."; Rec."Original Order No.")
            {
                ApplicationArea = all;
            }
            field("Original Order Line No. "; Rec."Original Order Line No. ")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }
}
