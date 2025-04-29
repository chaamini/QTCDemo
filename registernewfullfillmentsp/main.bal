import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/log;

configurable string user = ?;
configurable string password = ?;
configurable string host = ?;
configurable int port = ?;

listener http:Listener httpDefaultListener = http:getDefaultListener();

final mysql:Client db = check new (user = user, password = password, database = "defaultdb", host = host, port = port);
// Create table on startup
function init() returns error? {
    sql:ExecutionResult _ = check db->execute(`CREATE TABLE IF NOT EXISTS ServiceProviders (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255),
        serviceDesc VARCHAR(512),
        crmUrl VARCHAR(512)
    )`);
}
service / on httpDefaultListener {
    resource function get registerFulFillmentSP(FulFillmentSP newSP) returns error|string {
        log:printInfo("Service Provider added: " + newSP.Name);

        // Insert into DB
        _ = check db->execute(
            `INSERT INTO ServiceProviders (name, serviceDesc, crmUrl)
             VALUES (${newSP.Name}, ${newSP.ServiceDesc}, ${newSP.CRMURL})`
        );
   
        return "Service Provider added successfully";
    }
}
