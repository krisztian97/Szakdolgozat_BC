codeunit 50100 ReturnOrderMgt
{
    TableNo = 50103;

    procedure ReturnOrder(var ComplaintResult: Record "Complaint Result")
    var
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Return Order Nos.", Today, true);
        SalesHeader."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.ReturnOrder;
        SalesHeader.Insert(true);
        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.ReturnOrder);
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;
        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
    end;

    procedure RepairOrder(var ComplaintResult: Record "Complaint Result")
    var
        myInt: Integer;
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Return Order Nos.", Today, true);
        SalesHeader."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.RepairOrder;
        SalesHeader.Insert(true);
        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.RepairOrder);
                    SalesLine.VALIDATE("Line Discount %", 100);
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;
        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
    end;

    procedure ReplacementOrder(var ComplaintResult: Record "Complaint Result")
    var
        myInt: Integer;
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Return Order Nos.", Today, true);
        SalesHeader."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.ReplacementOrder;
        SalesHeader.Insert(true);

        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.ReplacementOrder);
                    SalesLine.VALIDATE("Line Discount %", 100);
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;
        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
        CreateSalesOrder(ComplaintResult, SalesHeader);

    end;

    local procedure CreateSalesOrder(var ComplaintResult: Record "Complaint Result"; SalesReturnOrderNo: Record "Sales Header")
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesReceivablesSetup.TESTFIELD("Order Nos.");
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Order Nos.", Today, true);
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.ReplacementOrder;
        SalesHeader."Replacement Order No" := SalesReturnOrderNo."No.";
        SalesHeader.Insert(true);
        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;

        PAGE.RUN(PAGE::"Sales Order", SalesHeader);
    end;

    procedure TransportDamage(var ComplaintResult: Record "Complaint Result")
    var
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Return Order Nos.", Today, true);
        SalesHeader."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.TransportDamage;
        SalesHeader.Insert(true);
        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.TransportDamage);
                    SalesLine.VALIDATE("Line Discount %", 100);
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;
        PAGE.RUN(PAGE::"Sales Return Order", SalesHeader);
    end;

    procedure Loss(var ComplaintResult: Record "Complaint Result")
    var
        myInt: Integer;
    begin
        SalesReceivablesSetup.GET;
        ComplaintSetup.GET;
        SalesReceivablesSetup.TESTFIELD("Return Order Nos.");
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := NoSeriesManagement.GetNextNo(SalesReceivablesSetup."Return Order Nos.", Today, true);
        SalesHeader."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
        SalesHeader.Validate("Sell-to Customer No.", ComplaintResult."Customer No.");
        SalesHeader."Order Type" := ComplaintSetup.Loss;
        SalesHeader.Insert(true);
        if ComplaintResult.FindSet() then
            repeat
                if (ComplaintResult."Return Quantity" <> 0) then begin
                    ILE.Reset();
                    ILE.SetRange("Original Order No.", ComplaintResult."Original Order No.");
                    SalesLine.Init();
                    SalesLine."Line No." := ComplaintResult."Line No.";
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Location Code" := SalesHeader."Location Code";
                    SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Bill-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SalesLine."Gen. Bus. Posting Group" := ComplaintResult."Gen. Bus. Posting Group";
                    SalesLine.VALIDATE(SalesLine.Type, SalesLine.Type::Item);
                    SalesLine.VALIDATE("No.", ComplaintResult."Item No.");
                    SalesLine.VALIDATE(Quantity, ComplaintResult."Return Quantity");
                    SalesLine.VALIDATE("Return Reason Code", ComplaintSetup.Loss);
                    SalesLine.VALIDATE("Line Discount %", 100);
                    SalesLine.INSERT(true);
                end;
            until ComplaintResult.Next() = 0;
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