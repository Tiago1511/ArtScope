//
//  HighlightViewModel.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import Foundation
import UIKit

class HighlightViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> HighlightViewModel {
        HighlightViewModel()
    }
    
    var highlight: Object?
    
}
