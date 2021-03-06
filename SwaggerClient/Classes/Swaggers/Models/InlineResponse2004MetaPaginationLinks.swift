//
// InlineResponse2004MetaPaginationLinks.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** The pagination links */
public class InlineResponse2004MetaPaginationLinks: JSONEncodable {
    public var previous: String?
    public var next: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["previous"] = self.previous
        nillableDictionary["next"] = self.next
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
