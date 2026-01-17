//
//  ArtDetilsViewModel.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit

class ArtDetilsViewModel: GenericViewModel, ViewModelFactory {

    static func make() -> ArtDetilsViewModel {
        ArtDetilsViewModel()
    }
    
    var art: Object?
    
}
