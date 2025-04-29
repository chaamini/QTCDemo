import ballerina/log;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable string user = ?;
configurable string password = ?;
configurable string host = ?;
configurable int port = ?;

type ServiceProvider record {
    string Name;
    string ServiceDesc;
    string CRMURL;
};


final mysql:Client db = check new (user = user, password = password, database = "defaultdb", host = host, port = port);

function syncWithFulfillmentCRMs(Account account) {
    
    stream<ServiceProvider, sql:Error?> SPList =  db->query(`SELECT * FROM ServiceProviders;`);
    
    ServiceProvider[] serviceProviders = [];
    error? e = SPList.forEach(function(ServiceProvider sp) {
        serviceProviders.push(sp);
        // updateEachSP with the new Account Details 
        //_ = check http->post(SPCRMURL, account);
    });
    if e is error {
        log:printError("Error occurred while processing the stream", 'error = e);
        return;
    }

    log:printInfo("Account synced to all CRMs");
}
