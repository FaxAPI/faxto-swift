//
// InlineResponse200.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class InlineResponse200: JSONEncodable {
    /** The status of the API request */
    public var status: String?
    /** The id of the fax job. It is used to check the status of the fax job. */
    public var faxJobId: Int32?
    /** The remaining cash balance */
    public var userCashBalance: Double?
    /** The cost of sending fax */
    public var cost: Double?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["status"] = self.status
        nillableDictionary["fax_job_id"] = self.faxJobId?.encodeToJSON()
        nillableDictionary["user_cash_balance"] = self.userCashBalance
        nillableDictionary["cost"] = self.cost
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}