codeunit 50104 TransferHandler
{
    procedure CopyFieldFromTransferHeaderToTransferShipmentHeader(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Original Order No." := TransferHeader."Original Order No.";
    end;

}