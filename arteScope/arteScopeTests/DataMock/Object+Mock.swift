//
//  Object+Mock.swift
//  arteScopeTests
//
//  Created by tiago on 05/02/2026.
//

import Foundation

@testable import arteScope

struct ArtTestData {
    
    static func sampleArt() -> Object {
        
        let art = Object(
            objectId: 441769,
            isHighlight: true,
            isPublicDomain: true,
            imageURL: "https://images.metmuseum.org/CRDImages/ep/original/DP322015.jpg",
            imageSmallURL: "https://images.metmuseum.org/CRDImages/ep/web-large/DP322015.jpg",
            department: "European Paintings",
            title: "Virgil's Tomb by Moonlight, with Silius Italicus Declaiming",
            artistName: "Joseph Wright (Wright of Derby)",
            artistBio: "British, Derby 1734–1797 Derby",
            artistNationality: "British",
            artistBeginYear: "1734",
            artistEndYear: "1797",
            artistGender: "",
            dimensions: "40 x 50 in. (101.6 x 127 cm)",
            objectURL: "https://www.wikidata.org/wiki/Q19912176"
        )
        return art
    }
}
