import ballerina/http;
import ballerina/log;

listener http:Listener httpDefaultListener = http:getDefaultListener();

map<Account> accountStore = {};

service / on httpDefaultListener {
    resource function post newAccount(Account account) returns error|json {
        string accountId = account.Id;
        accountStore[accountId] = account;
        syncWithFulfillmentCRMs(account);

        log:printInfo("Received account: " + account.toString());
    }
}
