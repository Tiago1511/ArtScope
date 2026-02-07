//
//  ArtDetilsViewModel.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit
import CoreData

class ArtDetilsViewModel: GenericViewModel, ViewModelFactory {

    // Init exige injeção
    init(persistence: ArtPersistenceProtocol) {
        self.persistence = persistence
    }
       
    // Factory para produção (Core Data real)
    static func make() -> ArtDetilsViewModel {
        let persistence = ArtCoreDataManager(
            context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        )
        return ArtDetilsViewModel(persistence: persistence)
    }
    
    var art: Object?
    private let persistence: ArtPersistenceProtocol
        
    
    //MARK: - Clousers
    var showSuccessAlert: ((_ title: String, _ message : String) -> Void)?
    
    //MARK: - Favorite
    func saveArtToFavorites() {
        guard let art = art else {
            self.showAlert?(NSLocalizedString("errorFavoriteAdding", comment: ""))
            return
        }
        
        showLoading?()
        
        persistence.saveArt(art) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoading?()
                switch result {
                case .success():
                    self?.showSuccessAlert?(NSLocalizedString("success", comment: ""),
                                            NSLocalizedString("addedSuccessfully", comment: ""))
                case .failure(_):
                    self?.showAlert?(NSLocalizedString("errorFavoriteAdding", comment: ""))
                }
            }
        }
    }
    
}
