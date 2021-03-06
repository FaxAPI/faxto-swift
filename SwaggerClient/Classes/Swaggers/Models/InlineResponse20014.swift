//
// InlineResponse20014.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class InlineResponse20014: JSONEncodable {
    /** The status of the API request */
    public var status: String?
    /** Area Codes data */
    public var areacodes: [InlineResponse20014Areacodes]?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["status"] = self.status
        nillableDictionary["areacodes"] = self.areacodes?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
