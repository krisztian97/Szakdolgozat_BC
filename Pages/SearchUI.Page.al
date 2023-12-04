page 50101 "Search"
{
    Caption = 'Complaint List';
    PageType = Worksheet;
    SourceTable = "Complaint Result";
    UsageCategory = Tasks;
    ApplicationArea = All;
    SourceTableTemporary = true;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            Group(SearchGrp)
            {
                Caption = 'Complaints';
                field("Search Order No"; "Search Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Order No.';
                    Editable = true;
                    trigger OnValidate()
                    var
                    begin
                        Rec.DeleteAll();
                        Search.Update();
                        if "Search Order No." <> '' then SearchMgt.SearchWithOriginalOrderNo("Search Order No.", Rec);
                    end;
                }
                field(Customer; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                    Editable = true;
                    trigger OnValidate()
                    var
                    begin
                        Rec.DeleteAll();
                        Search.Update();
                        if CustomerName <> '' then SearchMgt.SearchWithName(CustomerName, Rec);
                    end;
                }
                field(CustomerNo; CustomerNumber)
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    TableRelation = Customer;
                    Editable = true;
                    trigger OnValidate()
                    var
                        Customer: Record Customer;
                    begin
                        Rec.DeleteAll();
                        Search.Update();
                        if CustomerNumber <> '' then begin
                            SearchMgt.SearchWithNo(CustomerNumber, Rec);
                            Customer.Reset();
                            Customer.GET("CustomerNumber");
                            CustomerName := Customer.Name;
                            Mail := Customer."E-Mail";
                            "Phone No" := Customer."Phone No.";
                        end;
                    end;
                }
                field("Mail"; "Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Mail';
                    Editable = true;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No';
                    Editable = true;
                }
            }
            repeater(General)
            {
                field("Original Order No."; Rec."Original Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Line No."; Rec."Original Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Desc."; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Ledger Entry No."; Rec."ItemLedgerEntryNo")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ShipmentDate; Rec.ShipmentDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity"; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Return Quantity"; Rec."Return Quantity")
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    var
                    begin
                        if (Rec."Return Quantity" < 0) Or (Rec."Return Quantity" > Rec.Quantity) Then Rec."Return Quantity" := 0;
                    end;
                }
            }
        }
        area(FactBoxes)
        {
            part(CustomerStatisticsFactBox; "Customer Statistics FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Customer No."),
                              "Date Filter" = field("Order Date");
                Visible = true;
            }
            part(Control1907234507; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("Customer No."),
                              "Date Filter" = field("Order Date");
                Visible = true;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Process)
            {
                action(Delete)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delete';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        Rec.DeleteAll();
                    end;
                }
            }
            group(Return)
            {

                action("Create Return Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Return Order';
                    Image = Create;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                ReturnOrderMgt.ReturnOrder(Rec);
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }
                action("Create Repair Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Repair Order';
                    Image = Create;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                ReturnOrderMgt.RepairOrder(Rec);
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }
                action("Create Replacement Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create Replacement Order';
                    Image = Create;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                ReturnOrderMgt.ReplacementOrder(Rec);
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }
                action("Transport Damage")
                {
                    ApplicationArea = All;
                    Caption = 'Create Return Order';
                    Image = Create;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                ReturnOrderMgt.TransportDamage(Rec);
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }
                action(Loss)
                {
                    ApplicationArea = All;
                    Caption = 'Loss';
                    Image = Create;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                ReturnOrderMgt.Loss(Rec);
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = All;
                    Caption = 'Create Credi tMemo';
                    Image = CreateCreditMemo;
                    trigger OnAction()
                    begin
                        if "Search Order No." <> '' then begin
                            if rec.FindSet() then
                                repeat
                                    if rec."Return Quantity" <> 0 then
                                        Return := true;
                                until rec.Next() = 0;
                            if Return then begin
                                if ComplaintSetup.AutoCreateCreditMemo then
                                    CreateCreditMemo.CreateCreditMemo(Rec);
                            end else
                                Message('Return Quantity must be bigger than 0!');
                        end else
                            Message('Order No Missing!');
                    end;
                }


            }
        }

    }
    var
        SearchTxt: Text;
        "CustomerName": Text;
        CustomerNumber: Text;
        CustomerTable: Record Customer;
        "Search Order No.": Code[20];
        SearchMgt: Codeunit "Search Management";
        ItemField: Text;
        "Phone No": Text;
        Mail: Text;
        Complaints: Record "Complaint Result";
        ReturnOrderMgt: Codeunit ReturnOrderMgt;
        Search: Page Search;
        Return: Boolean;
        ComplaintSetup: Record ComplaintSetup;
        CreateCreditMemo: Codeunit CreateCreditMemo;

}