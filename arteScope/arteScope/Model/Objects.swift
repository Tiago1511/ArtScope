//
//  Objects.swift
//  arteScope
//
//  Created by tiago on 05/01/2026.
//

import Foundation

struct Object: Codable {
    let objectId: Int
    let isHighlight: Bool
    let isPublicDomain: Bool
    let imageURL: String?
    let imageSmallURL: String?
    let department : String
    let title: String
    let artistName: String
    let artistBio: String?
    let artistNationality: String?
    let artistBeginYear: String
    let artistEndYear: String
    let artistGender: String
    let dimensions: String?
    let objectURL: String?
    
    enum CodingKeys: String, CodingKey {
        case objectId = "objectID"
        case isHighlight
        case isPublicDomain
        case imageURL = "primaryImage"
        case imageSmallURL = "primaryImageSmall"
        case department, title
        case artistName = "artistDisplayName"
        case artistBio = "artistDisplayBio"
        case artistNationality
        case artistBeginYear = "artistBeginDate"
        case artistEndYear = "artistEndDate"
        case artistGender
        case dimensions
        case objectURL = "objectWikidata_URL"
    }
}

struct Objects: Codable {
    var total: Int
    var objectsIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case total
        case objectsIds = "objectIDs"
    }
}
