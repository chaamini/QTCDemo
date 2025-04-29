import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

// Receive order status updates from external CRM

service / on httpDefaultListener {

    resource function post orderStatusUpdate(Order orderUpdate) returns string|error? {
        string orderId = orderUpdate.Id;
        string newStatus = orderUpdate.Status;

        // Optionally update Central CRM here or trigger notification
        log:printInfo("Order Status Updated: Order ID = " + orderId + ", Status = " + newStatus);

        // If status is FINALIZED, trigger invoice creation
        if newStatus == "FINALIZED" {
            processFinalizedInvoice(orderUpdate);
        }

        return "Status update processed";
    }
}
