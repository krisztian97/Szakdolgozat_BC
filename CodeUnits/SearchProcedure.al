codeunit 50102 "Search Management"
{
    procedure Search(SearchOrderNo: Text; SearchCustomer: Text; SearchCustomerNo: Text; var Result: Record "Complaint Result" temporary)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Items: Record "Item";
        LastResult: Integer;
    begin

    end;

    procedure SearchWithName(SearchCustomer: Text; var Result: Record "Complaint Result" temporary)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Items: Record "Item";
        LastResult: Integer;
    begin
        SearchCustomer := SearchCustomer.ToLower();
        SalesShipmentHeader.Reset();
        if SalesShipmentHeader.FindFirst() then
            repeat
                if format(SalesShipmentHeader."Sell-to Customer Name").ToLower().Contains(SearchCustomer) then
                    SalesShipmentHeader.SetRange("Sell-to Customer Name", SalesShipmentHeader."Sell-to Customer Name");
            until SalesShipmentHeader.Next() = 0;
        if SalesShipmentHeader.FindFirst() then
            repeat
                SalesShipmentLine.Reset();
                SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                if SalesShipmentLine.FindFirst() then
                    repeat
                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                        ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                        ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                        if ItemLedgerEntry.FindFirst() then
                            repeat
                                if ItemLedgerEntry."Original Order No." <> '' then begin
                                    LastResult += 1;
                                    Result.Init();
                                    Result."Original Order No." := ItemLedgerEntry."Original Order No.";
                                    Result."Original Line No." := ItemLedgerEntry."Original Order Line No. ";
                                    Result."Line No." := LastResult;
                                    Result."Order No." := SalesShipmentHeader."No.";
                                    Result."Customer Name" := SalesShipmentHeader."Ship-to Name";
                                    Result."Item No." := ItemLedgerEntry."Item No.";
                                    Result."Order Date" := SalesShipmentHeader."Order Date";
                                    Result.ItemLedgerEntryNo := ItemLedgerEntry."Entry No.";
                                    Result.Quantity := Abs(ItemLedgerEntry."Shipped Qty. Not Returned");
                                    Result."Customer No." := SalesShipmentHeader."Sell-to Customer No.";
                                    Result.ShipmentDate := SalesShipmentHeader."Shipment Date";
                                    if Items.get(ItemLedgerEntry."Item No.") then Result."Item Description" := Items."Description";
                                    Result.Insert();
                                end;
                            until ItemLedgerEntry.next() = 0;
                    until SalesShipmentLine.Next() = 0;
            until SalesShipmentHeader.Next() = 0;
    end;

    procedure SearchWithNo(SearchCustomerNo: Text; var Result: Record "Complaint Result" temporary)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Items: Record "Item";
        LastResult: Integer;
    begin
        SalesShipmentHeader.Reset();
        SalesShipmentHeader.SetRange("Sell-to Customer No.", SearchCustomerNo);
        if SalesShipmentHeader.FindFirst() then
            repeat
                SalesShipmentLine.Reset();
                SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                if SalesShipmentLine.FindFirst() then
                    repeat
                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                        ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                        ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                        if ItemLedgerEntry.FindFirst() then
                            repeat
                                if ItemLedgerEntry."Original Order No." <> '' then begin
                                    LastResult += 1;
                                    Result.Init();
                                    Result."Original Order No." := ItemLedgerEntry."Original Order No.";
                                    Result."Original Line No." := ItemLedgerEntry."Original Order Line No. ";
                                    Result."Line No." := LastResult;
                                    Result."Order No." := SalesShipmentHeader."No.";
                                    Result."Customer Name" := SalesShipmentHeader."Ship-to Name";
                                    Result."Item No." := ItemLedgerEntry."Item No.";
                                    Result."Order Date" := SalesShipmentHeader."Order Date";
                                    Result.ItemLedgerEntryNo := ItemLedgerEntry."Entry No.";
                                    Result.Quantity := Abs(ItemLedgerEntry."Shipped Qty. Not Returned");
                                    Result."Customer No." := SalesShipmentHeader."Sell-to Customer No.";
                                    Result.ShipmentDate := SalesShipmentHeader."Shipment Date";
                                    if Items.get(ItemLedgerEntry."Item No.") then Result."Item Description" := Items."Description";
                                    Result.Insert();
                                end;
                            until ItemLedgerEntry.next() = 0;
                    until SalesShipmentLine.Next() = 0;
            until SalesShipmentHeader.Next() = 0;
    end;

    procedure SearchWithOriginalOrderNo(SearchOrderNo: Code[20]; var Result: Record "Complaint Result" temporary)
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Items: Record "Item";
        LastResult: Integer;
    begin
        SalesShipmentHeader.Reset();
        SalesShipmentHeader.SetRange("Original Order No.", SearchOrderNo);
        if SalesShipmentHeader.FindFirst() then
            repeat
                SalesShipmentLine.Reset();
                SalesShipmentLine.SetRange("Document No.", SalesShipmentHeader."No.");
                if SalesShipmentLine.FindFirst() then
                    repeat
                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                        ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                        ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                        if ItemLedgerEntry.FindFirst() then
                            repeat
                                if ItemLedgerEntry."Original Order No." <> '' then begin
                                    LastResult += 1;
                                    Result.Init();
                                    Result."Original Order No." := ItemLedgerEntry."Original Order No.";
                                    Result."Original Line No." := ItemLedgerEntry."Original Order Line No. ";
                                    Result."Line No." := LastResult;
                                    Result."Order No." := SalesShipmentHeader."No.";
                                    Result."Customer Name" := SalesShipmentHeader."Ship-to Name";
                                    Result."Item No." := ItemLedgerEntry."Item No.";
                                    Result."Order Date" := SalesShipmentHeader."Order Date";
                                    Result.ItemLedgerEntryNo := ItemLedgerEntry."Entry No.";
                                    Result.Quantity := Abs(ItemLedgerEntry."Shipped Qty. Not Returned");
                                    Result."Customer No." := SalesShipmentHeader."Sell-to Customer No.";
                                    Result."Gen. Bus. Posting Group" := SalesShipmentLine."Gen. Bus. Posting Group";
                                    if Items.get(ItemLedgerEntry."Item No.") then Result."Item Description" := Items."Description";
                                    Result.Insert();
                                end;
                            until ItemLedgerEntry.next() = 0;
                    until SalesShipmentLine.Next() = 0;
            until SalesShipmentHeader.Next() = 0;
    end;
}