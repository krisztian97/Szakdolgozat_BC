codeunit 50106 SalesLineMgt
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterGetSalesHeader', '', false, false)]
    local procedure OnAfterOnInsertSalesHeader(var SalesLine: Record "Sales Line")
    begin
        if SalesLine."Document Type" = SalesLine."Document Type"::Order then
            SalesLine."Original Order No." := SalesLine."Document No.";
    end;
}