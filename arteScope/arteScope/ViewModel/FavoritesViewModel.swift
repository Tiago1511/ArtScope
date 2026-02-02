//
//  FavoriteViewModel.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit
internal import CoreData

class FavoritesViewModel: GenericViewModel, ViewModelFactory {

    static func make() -> FavoritesViewModel {
        FavoritesViewModel()
    }
    
    var favorites: [Art] = []
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Closures
    var reloadCollection: (() -> Void)?
    
    // MARK: - CoreData
    func fetchFavorites() {
        showLoading?()
        favorites = []
        let request: NSFetchRequest<Art> = Art.fetchRequest()
        do {
            favorites = try contex.fetch(request)
            reloadCollection?()
            hideLoading?()
        } catch {
            hideLoading?()
            print(error)
        }
    }

}
