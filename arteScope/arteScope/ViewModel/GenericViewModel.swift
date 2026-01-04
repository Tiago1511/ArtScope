//
//  GenericViewModel.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import Foundation

protocol ViewModelFactory {
    associatedtype ViewModel: GenericViewModel
    static func make() -> ViewModel
}

class GenericViewModel {
    
    // MARK: - Closures
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    
    // MARK: - Service Requests
    let service : ServiceRequest = ServiceRequest.shared
    
    
}
