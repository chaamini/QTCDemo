import ballerina/log;
import ballerina/time;

function processFinalizedInvoice(Order orderDetails) {
    log:printInfo("Generating Invoice");

    Invoice invoice = {
        AccountId__c: orderDetails.AccountId,
        Balance__c: 0.0,
        CreatedById: orderDetails.OwnerId,
        CreatedDate: orderDetails.CreatedDate,
        Customer_Reference__c: null,
        Due_Date__c: "2023-01-15",
        Fortnox_Invoice_Number__c: null,
        Invoice_Date__c: (time:utcNow().toString()),
        Invoice_Text__c: "Inget fel funnet på pump. Båda fungerar på samma sätt och avger samma ljud. Kan vara ett ljud som uppkommer vid avfrostning kanske?",
        IsDeleted: false,
        LastModifiedById: orderDetails.OwnerId,
        LastModifiedDate: "2023-01-01T00:00:00Z",
        LastReferencedDate: "2023-01-01T00:00:00Z",
        LastViewedDate: "2023-01-01T00:00:00Z",
        Name: "INV-00000014",
        Our_Reference__c: "defaultReference",
        OwnerId: orderDetails.OwnerId,
        Payment_Terms_Days__c: "30",
        Record_Locked__c: false,
        Status__c: "New",
        SystemModstamp: "2023-01-01T00:00:00Z",
        Total_Amount__c: 3877.76,
        Work_OrderId__c: "defaultWorkOrderId",
        attributes: { "type": "Invoice__c", "url": "/services/data/v62.0/sobjects/Invoice__c/a0tcm000004OMujAAG" }
    ,Id: "a0tcm000004OMujAAG"};

    log:printInfo("Invoice Created" + invoice.toString());
}
