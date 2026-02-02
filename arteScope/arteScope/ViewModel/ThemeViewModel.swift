//
//  ThemeViewModel.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import Foundation

class ThemeViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> ThemeViewModel {
        ThemeViewModel()
    }
    
    var theme: Theme?
}
