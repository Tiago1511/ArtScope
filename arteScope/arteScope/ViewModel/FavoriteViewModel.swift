//
//  FaforiteViewModel.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteViewModel: GenericViewModel, ViewModelFactory {

    static func make() -> FavoriteViewModel {
        FavoriteViewModel()
    }
    
    var art: Art?
}
