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
    
    // MARK: - Service Requests
    let service : ServiceRequest = ServiceRequest.shared
    
    func getImage(
        from url: String,
        completionSuccess: @escaping (UIImage) -> Void
    ) {
        service.getImage(
            url: url,
            completionSuccess: { (image: UIImage) in
                completionSuccess(image)
                
            }, completionFailure:{ [weak self](errorMessage: String) in
                self?.hideLoading?()
                print(errorMessage)
                return
                
            }, completionTimeout:{ [weak self](errorMessage: String) in
                self?.hideLoading?()
                print(errorMessage)
                return
            }
        )
    }
    
    
}
