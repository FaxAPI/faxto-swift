//
// InlineResponse20015Data.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class InlineResponse20015Data: JSONEncodable {
    public var didGroupId: Int32?
    public var areaCode: String?
    public var cityName: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["did_group_id"] = self.didGroupId?.encodeToJSON()
        nillableDictionary["area_code"] = self.areaCode
        nillableDictionary["city_name"] = self.cityName
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}