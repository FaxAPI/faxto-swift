//
// InlineResponse20017.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class InlineResponse20017: JSONEncodable {
    /** The status of the API request */
    public var status: String?
    /** Numbers data */
    public var numbers: [InlineResponse20017Numbers]?
    public var meta: InlineResponse2004Meta?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["status"] = self.status
        nillableDictionary["numbers"] = self.numbers?.encodeToJSON()
        nillableDictionary["meta"] = self.meta?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
