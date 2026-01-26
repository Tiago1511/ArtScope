//
//  ThemeCollectionViewModel.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class ThemeCollectionViewModel: GenericViewModel, ViewModelFactory {

    static func make() -> ThemeCollectionViewModel {
        ThemeCollectionViewModel()
    }
    
    var object: Object?
}
