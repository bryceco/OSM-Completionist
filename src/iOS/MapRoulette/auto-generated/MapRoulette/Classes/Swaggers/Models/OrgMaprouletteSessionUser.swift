//
// OrgMaprouletteSessionUser.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct OrgMaprouletteSessionUser: Codable {

    public var _id: Int64
    public var created: String
    public var modified: String
    public var osmProfile: OrgMaprouletteSessionOSMProfile
    public var groups: [OrgMaprouletteSessionGroup]
    public var apiKey: String?
    public var guest: Bool
    public var settings: OrgMaprouletteSessionUserSettings
    public var properties: String?
    public var score: Int?

    public init(_id: Int64, created: String, modified: String, osmProfile: OrgMaprouletteSessionOSMProfile, groups: [OrgMaprouletteSessionGroup], apiKey: String?, guest: Bool, settings: OrgMaprouletteSessionUserSettings, properties: String?, score: Int?) {
        self._id = _id
        self.created = created
        self.modified = modified
        self.osmProfile = osmProfile
        self.groups = groups
        self.apiKey = apiKey
        self.guest = guest
        self.settings = settings
        self.properties = properties
        self.score = score
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case created
        case modified
        case osmProfile
        case groups
        case apiKey
        case guest
        case settings
        case properties
        case score
    }

}

