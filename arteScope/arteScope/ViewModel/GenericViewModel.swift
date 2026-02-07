//
//  GenericViewModel.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import Foundation
import UIKit

protocol ViewModelFactory {
    associatedtype ViewModel: GenericViewModel
    static func make() -> ViewModel
}

class GenericViewModel {
    
    // MARK: - Closures
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showAlert: ((String) -> Void)?
    
    // MARK: - Service Requests
    @MainActor
    let service : ServiceRequest = ServiceRequest.shared
    
    func getImage(from url: String) async throws -> UIImage {
        return try await service.getImage(url: url)
    }
    
    
}
