codeunit 50107 CreateCreditMemo
{
    procedure CreateCreditMemo(var SearchResult: Record "Complaint Result")
    var
        myInt: Integer;
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Credit Memo Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Credit Memo Nos.", Today, true);
        SalesHeader.Validate("Sell-to Customer No.", SearchResult."Customer No.");
        SalesHeader.Insert(true);
        if SearchResult.FindSet() then
            repeat
                if (SearchResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", SearchResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine.Type := SalesLine.Type::"Charge (Item)";
                    SalesLine."Line No." := SearchResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := SearchResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintSetup.ItemCharges);
                    SalesLine.VALIDATE(Quantity, SearchResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.ReturnOrder);
                    SalesLine.AssignedItemCharge();
                    SalesLine.INSERT(true);
                end;
            until SearchResult.Next() = 0;
        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        ILE: Record "Item Ledger Entry";
        ComplaintSetup: Record ComplaintSetup;
}