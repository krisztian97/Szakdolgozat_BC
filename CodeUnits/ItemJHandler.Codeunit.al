codeunit 50105 ItemJHandler
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure CopyFieldsFromItemjnlToItemLedgerEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry."Original Order No." := ItemJournalLine."Original Order No.";
        ItemLedgerEntry."Original Order Line No. " := ItemJournalLine."Original Order Line No. ";
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromSalesLine', '', true, true)]
    local procedure CopyFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line")
    begin
        ItemJnlLine."Original Order No." := SalesLine."Original Order No.";
        ItemJnlLine."Original Order Line No. " := SalesLine."Line No.";
    end;
}

