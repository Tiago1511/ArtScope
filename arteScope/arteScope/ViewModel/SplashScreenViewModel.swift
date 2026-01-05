//
//  SplashScreenViewMosdel.swift
//  arteScope
//
//  Created by tiago on 04/01/2026.
//

import UIKit

class SplashScreenViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> SplashScreenViewModel {
        SplashScreenViewModel()
    }
    
    private let reachability: Reachability = Reachability.shared
    
    // MARK: - Closures
    var connectToInternet: (() -> Void)?
    var nextStep: (() -> Void)?
    
    public func checkInternetConnection() {
        reachability.start { status in
            if status {
                self.nextStep?()
            } else {
                self.connectToInternet?()
            }
        }
        
    }
}
