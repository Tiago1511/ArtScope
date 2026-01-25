//
//  ArtDetilsViewModel.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit
internal import CoreData

class ArtDetilsViewModel: GenericViewModel, ViewModelFactory {

    static func make() -> ArtDetilsViewModel {
        ArtDetilsViewModel()
    }
    
    var art: Object?
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func saveArtToFavorites() {
        
        guard let art = self.art else { return }
        
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
        
        //save
        do {
            try context.save()
        }  catch {
            print("Error saving: \(error)")
        }
        
    }
    
}
