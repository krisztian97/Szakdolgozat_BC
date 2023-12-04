codeunit 50103 SalesHeaderHandlerMgt
{
    var
        TransferMgt: Codeunit TransferHandler;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', false, false)]
    local procedure OnAfterCopyFromTransferHeaderToShipmentHeader(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferMgt.CopyFieldFromTransferHeaderToTransferShipmentHeader(TransferShipmentHeader, TransferHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure OnAfterOnInsertSalesHeader(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            SalesHeader."Original Order No." := SalesHeader."No.";
    end;


}