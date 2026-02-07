//
//  Art+Mock.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation
import CoreData

@testable import arteScope

struct ArtMock {
    
    static func art(context: NSManagedObjectContext) -> Art {
        
        let newArt = Art(context: context)
        newArt.artTitle = ArtTestData.sampleArt().title
        newArt.artDepartment = ArtTestData.sampleArt().department
        newArt.artDimensions = ArtTestData.sampleArt().dimensions
        newArt.artImage = ArtTestData.sampleArt().imageURL

        return newArt
    }
    
    
    

}
