//
//  ServiceRequest.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire

class ServiceRequest {
    
    // MARK: - Singleton
    static let shared = ServiceRequest()
    
    private var apiClient: APIClient = .shared
    
    
    // MARK: - Getters
    func getDepartment(
        completionSuccess:@escaping (DepartmentResponse) -> Void,
        completionFailure:@escaping (String) -> Void,
        completionTimeout:@escaping (String) -> Void
    ){
        apiClient.request(
            endpoint: APIEndpoint.getDepartments,
            cachePolicy: .useCache,
            method: .get,
            headers: nil,
            parameters: nil,
            completionSuccess: { (artwork: DepartmentResponse) in
                completionSuccess(artwork)
            },
            completionFailure: { errorMessage in
                completionFailure(errorMessage)
            },
            completionTimeout: { errorMessage in
                completionFailure(errorMessage)
            }
        )

    }
    
    
}

