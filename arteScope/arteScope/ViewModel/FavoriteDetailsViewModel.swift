//
//  FavoriteDetailsViewModel.swift
//  arteScope
//
//  Created by tiago on 25/01/2026.
//

import UIKit
internal import CoreData

class FavoriteDetailsViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> FavoriteDetailsViewModel {
        FavoriteDetailsViewModel()
    }
    
    var art: Art?
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Clousers
    var showSuccessAlert: ((_ title: String, _ message: String) -> Void)?
    
    //MARK: - Favorite
    func removeArtToFavorites() {
        
        guard let art = self.art else { return }
        
        guard let artist = art.artist else { // if don't have artist remove art
            context.delete(art)
            return
        }
        
        context.delete(art)
        
        let arts = artist.art?.count ?? 0
        
        if arts <= 1 { // check artis have more arts
            context.delete(artist)
        }
        
        do {
            try context.save()
            showSuccessAlert?(NSLocalizedString("success", comment: ""), NSLocalizedString("successRemovingFavorite", comment: ""))
        } catch {
            print("Failed to remove from favorites: \(error)")
            showAlert?(NSLocalizedString("errorRemovingFavorites", comment: ""))
        }
        
    }
}
