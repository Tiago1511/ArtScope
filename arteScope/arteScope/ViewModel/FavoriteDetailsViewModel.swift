//
//  FavoriteDetailsViewModel.swift
//  arteScope
//
//  Created by tiago on 25/01/2026.
//

import UIKit
import CoreData

class FavoriteDetailsViewModel: GenericViewModel, ViewModelFactory {
    
    // Init exige injeção
    init(persistence: ArtPersistenceProtocol) {
        self.persistence = persistence
    }
       
    // Factory to prod (real Core Data)
    static func make() -> FavoriteDetailsViewModel {
        let persistence = ArtCoreDataManager(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        return FavoriteDetailsViewModel(persistence: persistence)
    }
    
    var art: Art?
    private let persistence: ArtPersistenceProtocol
    
    //MARK: - Clousers
    var showSuccessAlert: ((_ title: String, _ message: String) -> Void)?
    
    //MARK: - Favorite
    func removeArtToFavorites() {
        
        guard let art else {
            showAlert?(NSLocalizedString("errorRemovingFavorites", comment: ""))
            return
        }
        
        persistence.removeArt(art) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.showSuccessAlert?(NSLocalizedString("success", comment: ""), NSLocalizedString("successRemovingFavorite", comment: ""))
                case .failure(let error):
                    print("Failed to remove from favorites: \(error)")
                    self?.showAlert?(NSLocalizedString("errorRemovingFavorites", comment: ""))
                }
                
            }
        }
        
    }
}
