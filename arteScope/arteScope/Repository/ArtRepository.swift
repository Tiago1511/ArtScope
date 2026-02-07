//
//  Repository.swift
//  arteScope
//
//  Created by tiago on 05/02/2026.
//

import Foundation
import CoreData

class ArtCoreDataManager: ArtPersistenceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        
        do {
            let newArtist = Artist(context:context)
            newArtist.artistName = art.artistName
            newArtist.bibliography = art.artistBio
            newArtist.dateBirth = art.artistBeginYear
            newArtist.dateDeath = art.artistEndYear
            
            let newArt = Art(context: context)
            newArt.artTitle = art.title
            newArt.artDepartment = art.department
            newArt.artDimensions = art.dimensions
            newArt.artImage = art.imageURL
            
            newArt.artist = newArtist
            newArtist.art?.adding(newArtist)
            
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
        
    }
    
}
