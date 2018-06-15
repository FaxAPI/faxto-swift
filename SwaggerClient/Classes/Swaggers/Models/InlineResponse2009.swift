//
// InlineResponse2009.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class InlineResponse2009: JSONEncodable {
    public var status: String?
    public var userId: Int32?
    public var createdDate: NSDate?
    public var id: Int32?
    public var filename: String?
    public var origFilename: String?
    public var previewFile: String?
    public var previewImage: String?
    public var previewInStorage: Int32?
    public var fileExtension: String?
    public var filenameUploaded: String?
    public var filesize: String?
    public var s3: Int32?
    public var serverDocumentId: Int32?
    public var teamUserId: Int32?
    public var totalPages: Int32?
    public var updatedAt: NSDate?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["status"] = self.status
        nillableDictionary["user_id"] = self.userId?.encodeToJSON()
        nillableDictionary["created_date"] = self.createdDate?.encodeToJSON()
        nillableDictionary["id"] = self.id?.encodeToJSON()
        nillableDictionary["filename"] = self.filename
        nillableDictionary["orig_filename"] = self.origFilename
        nillableDictionary["preview_file"] = self.previewFile
        nillableDictionary["preview_image"] = self.previewImage
        nillableDictionary["preview_in_storage"] = self.previewInStorage?.encodeToJSON()
        nillableDictionary["file_extension"] = self.fileExtension
        nillableDictionary["filename_uploaded"] = self.filenameUploaded
        nillableDictionary["filesize"] = self.filesize
        nillableDictionary["s3"] = self.s3?.encodeToJSON()
        nillableDictionary["server_document_id"] = self.serverDocumentId?.encodeToJSON()
        nillableDictionary["team_user_id"] = self.teamUserId?.encodeToJSON()
        nillableDictionary["total_pages"] = self.totalPages?.encodeToJSON()
        nillableDictionary["updated_at"] = self.updatedAt?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}