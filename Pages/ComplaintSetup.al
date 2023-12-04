page 50102 ComplaintSetup
{
    Caption = 'Complaint Setup';
    PageType = Document;
    SourceTable = ComplaintSetup;
    UsageCategory = Documents;
    ApplicationArea = All;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(RepairOrder; Rec.RepairOrder)
                {
                    ToolTip = 'Specifies the value of the RepairOrder field.';
                    ApplicationArea = All;
                }
                field(Loss; Rec.Loss)
                {
                    ToolTip = 'Specifies the value of the Loss field.';
                    ApplicationArea = All;
                }
                field(ReplacementOrder; Rec.ReplacementOrder)
                {
                    ToolTip = 'Specifies the value of the ReplacementOrder field.';
                    ApplicationArea = All;
                }
                field(TransportDamage; Rec.TransportDamage)
                {
                    ToolTip = 'Specifies the value of the TransportDamage field.';
                    ApplicationArea = All;
                }
                field(ReturnOrder; Rec.ReturnOrder)
                {
                    ToolTip = 'Specifies the value of the Order Type Return Order field.';
                    ApplicationArea = All;
                }
                field(ItemCharges; Rec.ItemCharges)
                {
                    ToolTip = 'Specifies the value of the Item Charges field.';
                    ApplicationArea = All;
                }
                field(AutoCreateCreditMemo; Rec.AutoCreateCreditMemo)
                {
                    ToolTip = 'Specifies the value of the Create Credit Memo field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
