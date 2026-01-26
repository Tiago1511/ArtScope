//
//  ThemesViewModel.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class ThemesViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> ThemesViewModel {
        ThemesViewModel()
    }
    
    var objects: [Object] = []
    
    var themeSelected: Theme?

}
