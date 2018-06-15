// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> AnyObject
}

public enum ErrorResponse : ErrorType {
    case Error(Int, NSData?, ErrorType)
}

public class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: NSHTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for case let (key, value) as (String, String) in rawHeader {
            header[key] = value
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = dispatch_once_t()
class Decoders {
    static private var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz clazz: T.Type, decoder: ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as! AnyObject }
    }

    static func decode<T>(clazz clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.intValue as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.longLongValue as! T;
        }
        if T.self is NSUUID.Type && source is String {
            return NSUUID(UUIDString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is NSData.Type && source is String {
            return NSData(base64EncodedString: source as! String, options: NSDataBase64DecodingOptions()) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static private func initialize() {
        dispatch_once(&once) {
            let formatters = [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                "yyyy-MM-dd'T'HH:mm:ss'Z'",
                "yyyy-MM-dd'T'HH:mm:ss.SSS"
            ].map { (format: String) -> NSDateFormatter in
                let formatter = NSDateFormatter()
                formatter.locale = NSLocale(localeIdentifier:"en_US_POSIX")
                formatter.dateFormat = format
                return formatter
            }
            // Decoder for NSDate
            Decoders.addDecoder(clazz: NSDate.self) { (source: AnyObject) -> NSDate in
               if let sourceString = source as? String {
                    for formatter in formatters {
                        if let date = formatter.dateFromString(sourceString) {
                            return date
                        }
                    }

                }
                if let sourceInt = source as? Int {
                    // treat as a java date
                    return NSDate(timeIntervalSince1970: Double(sourceInt / 1000) )
                }
                fatalError("formatter failed to parse \(source)")
            }

            // Decoder for ISOFullDate
            Decoders.addDecoder(clazz: ISOFullDate.self, decoder: { (source: AnyObject) -> ISOFullDate in
                if let string = source as? String,
                   let isoDate = ISOFullDate.from(string: string) {
                    return isoDate
                }
                fatalError("formatter failed to parse \(source)")
            }) 

            // Decoder for [InlineResponse200]
            Decoders.addDecoder(clazz: [InlineResponse200].self) { (source: AnyObject) -> [InlineResponse200] in
                return Decoders.decode(clazz: [InlineResponse200].self, source: source)
            }
            // Decoder for InlineResponse200
            Decoders.addDecoder(clazz: InlineResponse200.self) { (source: AnyObject) -> InlineResponse200 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse200()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.faxJobId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["fax_job_id"])
                instance.userCashBalance = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["user_cash_balance"])
                instance.cost = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["cost"])
                return instance
            }


            // Decoder for [InlineResponse2001]
            Decoders.addDecoder(clazz: [InlineResponse2001].self) { (source: AnyObject) -> [InlineResponse2001] in
                return Decoders.decode(clazz: [InlineResponse2001].self, source: source)
            }
            // Decoder for InlineResponse2001
            Decoders.addDecoder(clazz: InlineResponse2001.self) { (source: AnyObject) -> InlineResponse2001 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2001()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.cost = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["cost"])
                return instance
            }


            // Decoder for [InlineResponse20010]
            Decoders.addDecoder(clazz: [InlineResponse20010].self) { (source: AnyObject) -> [InlineResponse20010] in
                return Decoders.decode(clazz: [InlineResponse20010].self, source: source)
            }
            // Decoder for InlineResponse20010
            Decoders.addDecoder(clazz: InlineResponse20010.self) { (source: AnyObject) -> InlineResponse20010 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20010()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.url = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["url"])
                return instance
            }


            // Decoder for [InlineResponse20011]
            Decoders.addDecoder(clazz: [InlineResponse20011].self) { (source: AnyObject) -> [InlineResponse20011] in
                return Decoders.decode(clazz: [InlineResponse20011].self, source: source)
            }
            // Decoder for InlineResponse20011
            Decoders.addDecoder(clazz: InlineResponse20011.self) { (source: AnyObject) -> InlineResponse20011 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20011()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                return instance
            }


            // Decoder for [InlineResponse20012]
            Decoders.addDecoder(clazz: [InlineResponse20012].self) { (source: AnyObject) -> [InlineResponse20012] in
                return Decoders.decode(clazz: [InlineResponse20012].self, source: source)
            }
            // Decoder for InlineResponse20012
            Decoders.addDecoder(clazz: InlineResponse20012.self) { (source: AnyObject) -> InlineResponse20012 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20012()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.data = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["data"])
                return instance
            }


            // Decoder for [InlineResponse20012Data]
            Decoders.addDecoder(clazz: [InlineResponse20012Data].self) { (source: AnyObject) -> [InlineResponse20012Data] in
                return Decoders.decode(clazz: [InlineResponse20012Data].self, source: source)
            }
            // Decoder for InlineResponse20012Data
            Decoders.addDecoder(clazz: InlineResponse20012Data.self) { (source: AnyObject) -> InlineResponse20012Data in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20012Data()
                instance.country = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country"])
                instance.slug = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["slug"])
                instance.a2Code = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["a2_code"])
                instance.dialCode = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["dial_code"])
                return instance
            }


            // Decoder for [InlineResponse20013]
            Decoders.addDecoder(clazz: [InlineResponse20013].self) { (source: AnyObject) -> [InlineResponse20013] in
                return Decoders.decode(clazz: [InlineResponse20013].self, source: source)
            }
            // Decoder for InlineResponse20013
            Decoders.addDecoder(clazz: InlineResponse20013.self) { (source: AnyObject) -> InlineResponse20013 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20013()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.states = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["states"])
                return instance
            }


            // Decoder for [InlineResponse20013States]
            Decoders.addDecoder(clazz: [InlineResponse20013States].self) { (source: AnyObject) -> [InlineResponse20013States] in
                return Decoders.decode(clazz: [InlineResponse20013States].self, source: source)
            }
            // Decoder for InlineResponse20013States
            Decoders.addDecoder(clazz: InlineResponse20013States.self) { (source: AnyObject) -> InlineResponse20013States in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20013States()
                instance.id = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["id"])
                instance.name = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["name"])
                instance.code = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["code"])
                return instance
            }


            // Decoder for [InlineResponse20014]
            Decoders.addDecoder(clazz: [InlineResponse20014].self) { (source: AnyObject) -> [InlineResponse20014] in
                return Decoders.decode(clazz: [InlineResponse20014].self, source: source)
            }
            // Decoder for InlineResponse20014
            Decoders.addDecoder(clazz: InlineResponse20014.self) { (source: AnyObject) -> InlineResponse20014 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20014()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.areacodes = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["areacodes"])
                return instance
            }


            // Decoder for [InlineResponse20014Areacodes]
            Decoders.addDecoder(clazz: [InlineResponse20014Areacodes].self) { (source: AnyObject) -> [InlineResponse20014Areacodes] in
                return Decoders.decode(clazz: [InlineResponse20014Areacodes].self, source: source)
            }
            // Decoder for InlineResponse20014Areacodes
            Decoders.addDecoder(clazz: InlineResponse20014Areacodes.self) { (source: AnyObject) -> InlineResponse20014Areacodes in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20014Areacodes()
                instance.countryCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country_code"])
                instance.stateId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["state_id"])
                instance.areaCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["area_code"])
                return instance
            }


            // Decoder for [InlineResponse20015]
            Decoders.addDecoder(clazz: [InlineResponse20015].self) { (source: AnyObject) -> [InlineResponse20015] in
                return Decoders.decode(clazz: [InlineResponse20015].self, source: source)
            }
            // Decoder for InlineResponse20015
            Decoders.addDecoder(clazz: InlineResponse20015.self) { (source: AnyObject) -> InlineResponse20015 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20015()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.data = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["data"])
                return instance
            }


            // Decoder for [InlineResponse20015Data]
            Decoders.addDecoder(clazz: [InlineResponse20015Data].self) { (source: AnyObject) -> [InlineResponse20015Data] in
                return Decoders.decode(clazz: [InlineResponse20015Data].self, source: source)
            }
            // Decoder for InlineResponse20015Data
            Decoders.addDecoder(clazz: InlineResponse20015Data.self) { (source: AnyObject) -> InlineResponse20015Data in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20015Data()
                instance.didGroupId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["did_group_id"])
                instance.areaCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["area_code"])
                instance.cityName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["city_name"])
                return instance
            }


            // Decoder for [InlineResponse20016]
            Decoders.addDecoder(clazz: [InlineResponse20016].self) { (source: AnyObject) -> [InlineResponse20016] in
                return Decoders.decode(clazz: [InlineResponse20016].self, source: source)
            }
            // Decoder for InlineResponse20016
            Decoders.addDecoder(clazz: InlineResponse20016.self) { (source: AnyObject) -> InlineResponse20016 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20016()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                instance.data = Decoders.decodeOptional(clazz: InlineResponse20016Data.self, source: sourceDictionary["data"])
                return instance
            }


            // Decoder for [InlineResponse20016Data]
            Decoders.addDecoder(clazz: [InlineResponse20016Data].self) { (source: AnyObject) -> [InlineResponse20016Data] in
                return Decoders.decode(clazz: [InlineResponse20016Data].self, source: source)
            }
            // Decoder for InlineResponse20016Data
            Decoders.addDecoder(clazz: InlineResponse20016Data.self) { (source: AnyObject) -> InlineResponse20016Data in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20016Data()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.didId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["did_id"])
                instance.didGroupId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["did_group_id"])
                instance.countryCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country_code"])
                instance.cityName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["city_name"])
                instance.areaCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["area_code"])
                instance.number = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["number"])
                instance.type = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["type"])
                instance.trunkId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["trunk_id"])
                return instance
            }


            // Decoder for [InlineResponse20017]
            Decoders.addDecoder(clazz: [InlineResponse20017].self) { (source: AnyObject) -> [InlineResponse20017] in
                return Decoders.decode(clazz: [InlineResponse20017].self, source: source)
            }
            // Decoder for InlineResponse20017
            Decoders.addDecoder(clazz: InlineResponse20017.self) { (source: AnyObject) -> InlineResponse20017 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20017()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.numbers = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["numbers"])
                instance.meta = Decoders.decodeOptional(clazz: InlineResponse2004Meta.self, source: sourceDictionary["meta"])
                return instance
            }


            // Decoder for [InlineResponse20017Numbers]
            Decoders.addDecoder(clazz: [InlineResponse20017Numbers].self) { (source: AnyObject) -> [InlineResponse20017Numbers] in
                return Decoders.decode(clazz: [InlineResponse20017Numbers].self, source: source)
            }
            // Decoder for InlineResponse20017Numbers
            Decoders.addDecoder(clazz: InlineResponse20017Numbers.self) { (source: AnyObject) -> InlineResponse20017Numbers in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse20017Numbers()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.orderReference = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["order_reference"])
                instance.countryCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country_code"])
                instance.country = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["country"])
                instance.cityName = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["city_name"])
                instance.areaCode = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["area_code"])
                instance.didGroupId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["did_group_id"])
                instance.didNumber = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["did_number"])
                instance.expirationDate = Decoders.decodeOptional(clazz: ISOFullDate.self, source: sourceDictionary["expiration_date"])
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                return instance
            }


            // Decoder for [InlineResponse2002]
            Decoders.addDecoder(clazz: [InlineResponse2002].self) { (source: AnyObject) -> [InlineResponse2002] in
                return Decoders.decode(clazz: [InlineResponse2002].self, source: source)
            }
            // Decoder for InlineResponse2002
            Decoders.addDecoder(clazz: InlineResponse2002.self) { (source: AnyObject) -> InlineResponse2002 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2002()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                instance.userCashBalance = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["user_cash_balance"])
                return instance
            }


            // Decoder for [InlineResponse2003]
            Decoders.addDecoder(clazz: [InlineResponse2003].self) { (source: AnyObject) -> [InlineResponse2003] in
                return Decoders.decode(clazz: [InlineResponse2003].self, source: source)
            }
            // Decoder for InlineResponse2003
            Decoders.addDecoder(clazz: InlineResponse2003.self) { (source: AnyObject) -> InlineResponse2003 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2003()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.history = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["history"])
                return instance
            }


            // Decoder for [InlineResponse2003Created]
            Decoders.addDecoder(clazz: [InlineResponse2003Created].self) { (source: AnyObject) -> [InlineResponse2003Created] in
                return Decoders.decode(clazz: [InlineResponse2003Created].self, source: source)
            }
            // Decoder for InlineResponse2003Created
            Decoders.addDecoder(clazz: InlineResponse2003Created.self) { (source: AnyObject) -> InlineResponse2003Created in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2003Created()
                instance.date = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["date"])
                instance.timezoneType = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["timezone_type"])
                instance.timezone = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["timezone"])
                return instance
            }


            // Decoder for [InlineResponse2003History]
            Decoders.addDecoder(clazz: [InlineResponse2003History].self) { (source: AnyObject) -> [InlineResponse2003History] in
                return Decoders.decode(clazz: [InlineResponse2003History].self, source: source)
            }
            // Decoder for InlineResponse2003History
            Decoders.addDecoder(clazz: InlineResponse2003History.self) { (source: AnyObject) -> InlineResponse2003History in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2003History()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.created = Decoders.decodeOptional(clazz: InlineResponse2003Created.self, source: sourceDictionary["created"])
                instance.documentId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["document_id"])
                instance.document = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["document"])
                instance.recipient = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["recipient"])
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                return instance
            }


            // Decoder for [InlineResponse2004]
            Decoders.addDecoder(clazz: [InlineResponse2004].self) { (source: AnyObject) -> [InlineResponse2004] in
                return Decoders.decode(clazz: [InlineResponse2004].self, source: source)
            }
            // Decoder for InlineResponse2004
            Decoders.addDecoder(clazz: InlineResponse2004.self) { (source: AnyObject) -> InlineResponse2004 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2004()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.inbox = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["inbox"])
                instance.meta = Decoders.decodeOptional(clazz: InlineResponse2004Meta.self, source: sourceDictionary["meta"])
                return instance
            }


            // Decoder for [InlineResponse2004Inbox]
            Decoders.addDecoder(clazz: [InlineResponse2004Inbox].self) { (source: AnyObject) -> [InlineResponse2004Inbox] in
                return Decoders.decode(clazz: [InlineResponse2004Inbox].self, source: source)
            }
            // Decoder for InlineResponse2004Inbox
            Decoders.addDecoder(clazz: InlineResponse2004Inbox.self) { (source: AnyObject) -> InlineResponse2004Inbox in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2004Inbox()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.didId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["did_id"])
                instance.filename = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filename"])
                instance.filesize = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filesize"])
                instance.number = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["number"])
                instance.sender = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["sender"])
                instance.totalPages = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["total_pages"])
                instance.createdAt = Decoders.decodeOptional(clazz: InlineResponse2003Created.self, source: sourceDictionary["created_at"])
                instance.previewFile = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["preview_file"])
                instance.fileUrl = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["file_url"])
                return instance
            }


            // Decoder for [InlineResponse2004Meta]
            Decoders.addDecoder(clazz: [InlineResponse2004Meta].self) { (source: AnyObject) -> [InlineResponse2004Meta] in
                return Decoders.decode(clazz: [InlineResponse2004Meta].self, source: source)
            }
            // Decoder for InlineResponse2004Meta
            Decoders.addDecoder(clazz: InlineResponse2004Meta.self) { (source: AnyObject) -> InlineResponse2004Meta in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2004Meta()
                instance.pagination = Decoders.decodeOptional(clazz: InlineResponse2004MetaPagination.self, source: sourceDictionary["pagination"])
                return instance
            }


            // Decoder for [InlineResponse2004MetaPagination]
            Decoders.addDecoder(clazz: [InlineResponse2004MetaPagination].self) { (source: AnyObject) -> [InlineResponse2004MetaPagination] in
                return Decoders.decode(clazz: [InlineResponse2004MetaPagination].self, source: source)
            }
            // Decoder for InlineResponse2004MetaPagination
            Decoders.addDecoder(clazz: InlineResponse2004MetaPagination.self) { (source: AnyObject) -> InlineResponse2004MetaPagination in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2004MetaPagination()
                instance.total = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["total"])
                instance.count = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["count"])
                instance.perPage = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["per_page"])
                instance.currentPage = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["current_page"])
                instance.totalPages = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["total_pages"])
                instance.links = Decoders.decodeOptional(clazz: InlineResponse2004MetaPaginationLinks.self, source: sourceDictionary["links"])
                return instance
            }


            // Decoder for [InlineResponse2004MetaPaginationLinks]
            Decoders.addDecoder(clazz: [InlineResponse2004MetaPaginationLinks].self) { (source: AnyObject) -> [InlineResponse2004MetaPaginationLinks] in
                return Decoders.decode(clazz: [InlineResponse2004MetaPaginationLinks].self, source: source)
            }
            // Decoder for InlineResponse2004MetaPaginationLinks
            Decoders.addDecoder(clazz: InlineResponse2004MetaPaginationLinks.self) { (source: AnyObject) -> InlineResponse2004MetaPaginationLinks in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2004MetaPaginationLinks()
                instance.previous = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["previous"])
                instance.next = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["next"])
                return instance
            }


            // Decoder for [InlineResponse2005]
            Decoders.addDecoder(clazz: [InlineResponse2005].self) { (source: AnyObject) -> [InlineResponse2005] in
                return Decoders.decode(clazz: [InlineResponse2005].self, source: source)
            }
            // Decoder for InlineResponse2005
            Decoders.addDecoder(clazz: InlineResponse2005.self) { (source: AnyObject) -> InlineResponse2005 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2005()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.apiKey = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["api_key"])
                return instance
            }


            // Decoder for [InlineResponse2006]
            Decoders.addDecoder(clazz: [InlineResponse2006].self) { (source: AnyObject) -> [InlineResponse2006] in
                return Decoders.decode(clazz: [InlineResponse2006].self, source: source)
            }
            // Decoder for InlineResponse2006
            Decoders.addDecoder(clazz: InlineResponse2006.self) { (source: AnyObject) -> InlineResponse2006 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2006()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.apiKey = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["api_key"])
                return instance
            }


            // Decoder for [InlineResponse2007]
            Decoders.addDecoder(clazz: [InlineResponse2007].self) { (source: AnyObject) -> [InlineResponse2007] in
                return Decoders.decode(clazz: [InlineResponse2007].self, source: source)
            }
            // Decoder for InlineResponse2007
            Decoders.addDecoder(clazz: InlineResponse2007.self) { (source: AnyObject) -> InlineResponse2007 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2007()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.balance = Decoders.decodeOptional(clazz: Double.self, source: sourceDictionary["balance"])
                return instance
            }


            // Decoder for [InlineResponse2008]
            Decoders.addDecoder(clazz: [InlineResponse2008].self) { (source: AnyObject) -> [InlineResponse2008] in
                return Decoders.decode(clazz: [InlineResponse2008].self, source: source)
            }
            // Decoder for InlineResponse2008
            Decoders.addDecoder(clazz: InlineResponse2008.self) { (source: AnyObject) -> InlineResponse2008 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2008()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.files = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["files"])
                return instance
            }


            // Decoder for [InlineResponse2008Files]
            Decoders.addDecoder(clazz: [InlineResponse2008Files].self) { (source: AnyObject) -> [InlineResponse2008Files] in
                return Decoders.decode(clazz: [InlineResponse2008Files].self, source: source)
            }
            // Decoder for InlineResponse2008Files
            Decoders.addDecoder(clazz: InlineResponse2008Files.self) { (source: AnyObject) -> InlineResponse2008Files in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2008Files()
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.filename = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filename"])
                instance.pages = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["pages"])
                instance.size = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["size"])
                instance.uploaded = Decoders.decodeOptional(clazz: ISOFullDate.self, source: sourceDictionary["uploaded"])
                return instance
            }


            // Decoder for [InlineResponse2009]
            Decoders.addDecoder(clazz: [InlineResponse2009].self) { (source: AnyObject) -> [InlineResponse2009] in
                return Decoders.decode(clazz: [InlineResponse2009].self, source: source)
            }
            // Decoder for InlineResponse2009
            Decoders.addDecoder(clazz: InlineResponse2009.self) { (source: AnyObject) -> InlineResponse2009 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse2009()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.userId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["user_id"])
                instance.createdDate = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["created_date"])
                instance.id = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["id"])
                instance.filename = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filename"])
                instance.origFilename = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["orig_filename"])
                instance.previewFile = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["preview_file"])
                instance.previewImage = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["preview_image"])
                instance.previewInStorage = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["preview_in_storage"])
                instance.fileExtension = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["file_extension"])
                instance.filenameUploaded = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filename_uploaded"])
                instance.filesize = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["filesize"])
                instance.s3 = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["s3"])
                instance.serverDocumentId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["server_document_id"])
                instance.teamUserId = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["team_user_id"])
                instance.totalPages = Decoders.decodeOptional(clazz: Int32.self, source: sourceDictionary["total_pages"])
                instance.updatedAt = Decoders.decodeOptional(clazz: NSDate.self, source: sourceDictionary["updated_at"])
                return instance
            }


            // Decoder for [InlineResponse400]
            Decoders.addDecoder(clazz: [InlineResponse400].self) { (source: AnyObject) -> [InlineResponse400] in
                return Decoders.decode(clazz: [InlineResponse400].self, source: source)
            }
            // Decoder for InlineResponse400
            Decoders.addDecoder(clazz: InlineResponse400.self) { (source: AnyObject) -> InlineResponse400 in
                let sourceDictionary = source as! [NSObject:AnyObject]
                let instance = InlineResponse400()
                instance.status = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["status"])
                instance.message = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["message"])
                return instance
            }
        }
    }
}