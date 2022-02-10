/// <summary>
/// Codeunit Events Utility (ID 58100).
/// </summary>
codeunit 58100 "Events Utility"
{

    Permissions = tabledata "Item Ledger Entry" = RIMD, tabledata "Warehouse Receipt Line" = RIMD, tabledata "Warehouse Shipment Line" = RIMD, tabledata "Warehouse Activity Line" = RIMD;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer)
    begin
        if SalesLine.type = SalesLine.Type::Item then
            SalesLine."Part No." := Item."Part No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer)
    begin
        if PurchLine.type = PurchLine.Type::Item then
            PurchLine."Part No." := Item."Part No.";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCreatePurchaseHeaderOnBeforeInsert', '', false, false)]
    local procedure OnCreatePurchaseHeaderOnBeforeInsert(var PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; Vendor: Record Vendor)
    begin
        PurchaseHeader."Order Reference Type" := SalesHeader."Document Type";
        PurchaseHeader."Order Reference No." := SalesHeader."No.";
        PurchaseHeader."Invoice Only" := SalesHeader."Invoice Only";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCopyToTempLinesLoop', '', false, false)]
    local procedure OnCopyToTempLinesLoop(var PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        Item: Record Item;
    begin
        if PurchLine."Document Type" <> PurchLine."Document Type"::Invoice then
            exit;
        PurchaseHeader.get(PurchLine."Document Type", PurchLine."Document No.");
        if not PurchaseHeader."Invoice Only" then
            exit;
        if PurchLine.type <> PurchLine.Type::Item then
            exit;
        IF iTEM.GET(PurchLine."No.") THEN begin
            Item."Inventory Value Zero" := true;
            item.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCopyToTempLines', '', false, false)]
    local procedure OnAfterCopyToTempLines(var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesHeader: Record "Sales Header";
        Item: Record Item;
    begin
        if TempSalesLine."Document Type" <> TempSalesLine."Document Type"::Invoice then
            exit;
        SalesHeader.get(TempSalesLine."Document Type", TempSalesLine."Document No.");
        if not SalesHeader."Invoice Only" then
            exit;

        if TempSalesLine.FindFirst() then
            repeat
                if (TempSalesLine.Type = TempSalesLine.Type::Item) AND (TempSalesLine."No." <> '') then begin
                    IF iTEM.GET(TempSalesLine."No.") THEN begin
                        Item."Inventory Value Zero" := true;
                        Item.Modify(true);
                    end;
                end;
            until TempSalesLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchLines', '', false, false)]
    local procedure OnAfterPostPurchLines(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; WhseShip: Boolean; WhseReceive: Boolean; var PurchLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempInvoicePostBuffer: Record "Invoice Post. Buffer" temporary; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        PurchLine: Record "Purchase Line";
        Item: Record Item;
    begin
        if PurchHeader."Document Type" <> PurchHeader."Document Type"::Invoice then
            exit;
        if not PurchHeader."Invoice Only" then
            exit;

        PurchLine.reset;
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange(Type, PurchLine.type::Item);
        PurchLine.SetFilter("No.", '<>%1', '');
        if PurchLine.FindFirst() then
            repeat
                if Item.Get(PurchLine."No.") then begin
                    Item."Inventory Value Zero" := false;
                    Item.Modify();
                end;
            until PurchLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean)
    var
        SalesInvLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        Item: Record Item;
    begin
        SalesInvHeader.get(SalesInvHdrNo);
        if not SalesInvHeader."Invoice Only" then
            exit;
        SalesInvLine.reset;
        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        if SalesInvLine.FindFirst() then
            repeat
                if Item.get(SalesInvLine."No.") then begin
                    Item."Inventory Value Zero" := false;
                    Item.Modify();
                end;
            until SalesInvLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItemReqLine(var RequisitionLine: Record "Requisition Line"; Item: Record Item)
    begin
        RequisitionLine."Part No." := Item."Part No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Price List Line", 'OnAfterCopyToPriceAsset', '', false, false)]

    local procedure OnAfterCopyToPriceAsset(var PriceAsset: Record "Price Asset")
    var
        Item: Record Item;
    begin
        if (PriceAsset."Asset Type" = PriceAsset."Asset Type"::Item) AND (PriceAsset."Asset No." <> '') then begin
            item.Get(PriceAsset."Asset No.");
            PriceAsset."Part No." := Item."Part No.";
            PriceAsset."Manufacturer Code " := Item."Manufacturer Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterUpdateSalesDocLines', '', false, false)]
    local procedure OnAfterUpdateSalesDocLines(var SalesHeader: Record "Sales Header"; var LinesWereModified: Boolean; PreviewMode: Boolean)
    var
        ShipMethod: Record "Shipment Method";
        OrderFullFillMgmt: codeunit "Order fulfilment Management";
    begin
        if SalesHeader."Shipment Method Code" = '' then
            exit;
        clear(OrderFullFillMgmt);
        SalesHeader."Expected Shipment Date" := OrderFullFillMgmt.GetNextShipmentDate(SalesHeader."Shipment Method Code", SalesHeader."Shipment Date");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales line", 'OnValidateQuantityOnAfterCalcBaseQty', '', false, false)]
    local procedure OnValidateQuantityOnAfterCalcBaseQty(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    var
        Item: Record Item;
        IsConfirmMsgShowed: Boolean;
    begin
        if (SalesLine.Type <> SalesLine.Type::Item) OR
            (SalesLine."No." = '') OR (SalesLine.Quantity = 0) then
            //(SalesLine."Document Type" <> SalesLine."Document Type"::Order) then //### v2.0
            exit;
        IsConfirmMsgShowed := false;
        if (SalesLine."Document Type") IN [SalesLine."Document Type"::Order, salesLine."Document Type"::Quote] then BEGIN //### v2.0
            Item.get(SalesLine."No.");
            if Item."Sales Minimum Order Qty" = 0 then
                exit;
            if SalesLine.Quantity < Item."Sales Minimum Order Qty" then begin
                IsConfirmMsgShowed := true;
                if not confirm(StrSubstNo('Quantity must be %1 or greater, and a multiple of %2. Do you wish to continue?', Item."Sales Minimum Order Qty", Item."Sales Multiplier")) THEN //### v2.0
                    ERROR('');
            end;
            IF (Item."Sales Multiplier" > 0) AND (Item."Sales Minimum Order Qty" > 0) AND (NOT IsConfirmMsgShowed) then begin
                if (((SalesLine.Quantity - ITEM."Sales Minimum Order Qty") / Item."Sales Multiplier") MOD 1) <> 0 then
                    IF NOT CONFIRM(StrSubstNo('Quantity must be %1 or greater, and a multiple of %2. Do you wish to continue?', Item."Sales Minimum Order Qty", Item."Sales Multiplier")) THEN
                        ERROR('')
            end;
        END;
    END;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        GenJournalLine."Double Blind Shipment" := SalesHeader."Double Blind Shipment";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."Double Blind Shipment" := GenJournalLine."Double Blind Shipment";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase line", 'OnValidateQuantityOnAfterCalcBaseQty', '', false, false)]
    local procedure PurchOnValidateQuantityOnAfterCalcBaseQty(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    var
        Item: Record Item;
        IsConfirmMsgShowed: Boolean;
    begin
        if (PurchaseLine.Type <> PurchaseLine.Type::Item) OR
            (PurchaseLine."No." = '') OR (PurchaseLine.Quantity = 0) OR
            (PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order) then
            exit;

        Item.get(PurchaseLine."No.");
        if Item."Purchase Minimum Order Qty" = 0 then
            exit;
        if PurchaseLine.Quantity < Item."Purchase Minimum Order Qty" then begin
            IsConfirmMsgShowed := true;
            if not confirm(StrSubstNo('Quantity must be %1 or greater, and a multiple of %2', Item."Purchase Minimum Order Qty", Item."Purchase Multiplier")) THEN
                Error('');
        end;

        IF (Item."Purchase Multiplier" > 0) AND (Item."Purchase Minimum Order Qty" > 0) and (NOT IsConfirmMsgShowed) then begin
            if (((PurchaseLine.Quantity - ITEM."Purchase Minimum Order Qty") / Item."Purchase Multiplier") MOD 1) <> 0 then
                if not confirm(StrSubstNo('Quantity must be %1 or greater, and a multiple of %2', Item."Purchase Minimum Order Qty", Item."Purchase Multiplier")) then
                    Error('');
        end;
    END;

    [EventSubscriber(ObjectType::table, Database::"Sales Line", 'OnAfterUpdateUnitPrice', '', false, false)]

    local procedure OnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CalledByFieldNo: Integer; CurrFieldNo: Integer)
    var
        CustPriceList: Record "Customer Price List";
        PriceListLine: Record "Price List Line";
        TempTable: record "Aging Band Buffer" temporary;
        HasFLICPriceList: Boolean;
        HasDateFilterApplied: Boolean;
    begin
        if SalesLine.Type <> SalesLine.type::Item then
            EXIT;
        if SalesLine.Quantity = 0 then BEGIN
            SalesLine.validate("Unit Price", 0);
            exit;
        END;

        HasFLICPriceList := false;
        HasDateFilterApplied := false;
        TempTable.DeleteAll();
        CustPriceList.reset;
        CustPriceList.SetRange("Customer No.", SalesLine."Bill-to Customer No.");
        if CustPriceList.FindFirst() then
            repeat
                PriceListLine.RESET;
                PriceListLine.SetRange("Price List Code", CustPriceList."Price List Code");
                PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
                PriceListLine.SetRange("Currency Code", SalesLine."Currency Code");
                PriceListLine.SetRange("Unit of Measure Code", SalesLine."Unit of Measure Code");
                PriceListLine.SetRange("Asset No.", SalesLine."No.");
                PriceListLine.SetRange(Status, PriceListLine.Status::Active);
                if PriceListLine.FindFirst() then
                    repeat
                        HasDateFilterApplied := true;
                        if (PriceListLine."Starting Date" <> 0D) AND (PriceListLine."Ending Date" <> 0D) THEN BEGIN
                            if (PriceListLine."Starting Date" <= SalesLine."Shipment Date") AND (PriceListLine."Ending Date" >= SalesLine."Shipment Date") then
                                HasDateFilterApplied := true
                            else
                                HasDateFilterApplied := false;
                        END ELSE begin
                            if (PriceListLine."Unit Price" > 0) AND (HasDateFilterApplied) THEN BEGIN
                                if IsFLIRPriceList(PriceListLine."Price List Code") THEN
                                    HasFLICPriceList := true;
                                if (PriceListLine."Minimum Quantity" <> 0) AND (PriceListLine."Minimum Quantity" <= SalesLine.Quantity) then begin
                                    TempTable.reset;
                                    TempTable.setrange("Currency Code", PriceListLine."Price List Code");
                                    if TempTable.FindFirst() then begin
                                        TempTable."Column 1 Amt." := PriceListLine."Unit Price";
                                        TempTable.Modify();
                                    end else begin
                                        TempTable.INIT;
                                        TempTable."Currency Code" := PriceListLine."Price List Code";
                                        TempTable."Column 1 Amt." := PriceListLine."Unit Price";
                                        TempTable.Insert();
                                    end;
                                END;
                            END;
                        end;
                    until PriceListLine.Next() = 0;

            until CustPriceList.Next() = 0;

        TempTable.RESET;
        TempTable.SetCurrentKey("Column 1 Amt.");
        TempTable.SetAscending("Column 1 Amt.", HasFLICPriceList);
        IF TempTable.FindLast() then
            SalesLine.validate("Unit Price", TempTable."Column 1 Amt.");
    end;


    local procedure IsFLIRPriceList(PriceListCode: Code[20]): Boolean
    var
        PriceListHeader: Record "Price List Header";
    begin
        if PriceListHeader.get(PriceListCode) then
            EXIT(PriceListHeader."Is FLIR Price List");
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeInsertItemLedgEntry', '', false, false)]

    procedure UpdatePartno(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry")
    var
        item: Record item;
    begin
        item.SetRange("No.", ItemLedgerEntry."Item No.");
        if item.FindFirst() then
            ItemLedgerEntry."Part No." := item."Part No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnPurchLine2ReceiptLineOnAfterInitNewLine', '', false, false)]

    procedure updatepartno1(var WhseReceiptLine: Record "Warehouse Receipt Line"; WhseReceiptHeader: Record "Warehouse Receipt Header"; PurchaseLine: Record "Purchase Line")
    var
        item: Record item;
    begin
        item.SetRange("No.", PurchaseLine."No.");
        if item.FindFirst() then begin
            WhseReceiptLine."Part No." := item."Part No.";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforeCreateShptLineFromSalesLine', '', false, false)]

    procedure updatepartno2(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        item: Record item;
    begin
        item.SetRange("No.", SalesLine."No.");
        if item.FindFirst() then begin
            WarehouseShipmentLine."Part No." := item."Part No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnValidateItemNoOnAfterGetItem', '', false, false)]

    procedure updateitem(var ItemJournalLine: Record "Item Journal Line"; Item: Record Item)
    begin
        ItemJournalLine."Part No." := Item."Part No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 7301, 'OnBeforeInsertWhseEntry', '', false, false)]

    procedure UpdatePartno3(var WarehouseEntry: Record "Warehouse Entry"; var WarehouseJournalLine: Record "Warehouse Journal Line")
    var
        item: Record item;
    begin
        item.SetRange("No.", WarehouseEntry."Item No.");
        if item.FindFirst() then
            WarehouseEntry."Part No." := item."Part No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, 7312, 'OnBeforeCreateWhseDocTakeLine', '', false, false)]

    procedure Updatepartno5(var WhseActivLine: Record "Warehouse Activity Line"; Location: Record Location; var IsHandled: Boolean)
    var
        item: Record item;
    begin
        item.SetRange("No.", WhseActivLine."Item No.");
        if item.FindFirst() then
            WhseActivLine."Part No." := item."Part No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, 7312, 'OnCreateWhseDocPlaceLineOnAfterTempWhseActivLineSetFilters', '', false, false)]

    procedure Updatepartno6(var TempWhseActivLine: Record "Warehouse Activity Line"; WhseActivLine: Record "Warehouse Activity Line")
    var
        item: Record item;
    begin
        item.SetRange("No.", WhseActivLine."Item No.");
        if item.FindFirst() then
            WhseActivLine."Part No." := item."Part No.";
    end;



    [EventSubscriber(ObjectType::Codeunit, 7312, 'OnAfterWhseActivLineInsert', '', false, false)]

    procedure Updatepartno8(var WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        item: Record item;
    begin

        item.SetRange("No.", WarehouseActivityLine."Item No.");
        if item.FindFirst() then
            WarehouseActivityLine."Part No." := item."Part No.";
        WarehouseActivityLine.Modify();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforeCreateShptLineFromPurchLine', '', false, false)]

    procedure updatepartno10(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchaseLine: Record "Purchase Line")
    var
        item: Record item;
    begin
        item.SetRange("No.", PurchaseLine."No.");
        if item.FindFirst() then begin
            WarehouseShipmentLine."Part No." := item."Part No.";
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderHeader', '', false, false)]

    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    begin
        if (RequisitionLine."Demand Type" = 37) AND (RequisitionLine."Demand Subtype" = RequisitionLine."Demand Subtype"::"1") then
            PurchaseOrderHeader."Order Reference Type" := PurchaseOrderHeader."Order Reference Type"::Order;
        PurchaseOrderHeader."Order Reference No." := RequisitionLine."Demand Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Doc. From Sales Doc.", 'OnCopySalesLinesToPurchaseLinesOnLineTypeValidate', '', false, false)]
    local procedure OnCopySalesLinesToPurchaseLinesOnLineTypeValidate(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if SalesLine.Type = SalesLine.Type::"Charge (Item)" then begin
            PurchaseLine.Type := PurchaseLine.Type::"Charge (Item)";
            IsHandled := true;
        end else
            if SalesLine.Type = SalesLine.Type::"G/L Account" then begin
                PurchaseLine.Type := PurchaseLine.Type::"G/L Account";
                IsHandled := true;
            end;
    end;

}