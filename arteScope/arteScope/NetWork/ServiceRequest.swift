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
    
    private var header: HTTPHeaders
    
    private var apiClient: APIClient = .shared
    
    init() {
        self.header = HTTPHeaders()
    }
    
    
    // MARK: - Getters
    
    func getDepartment(
        completionSuccess:@escaping (DepartmentResponse) -> Void,
        completionFailure:@escaping (String) -> Void,
        completionTimeout:@escaping (String) -> Void
    ){
        apiClient.request(
            endpoint: APIEndpoint.getDepartments,
            method: .get,
            parameters: nil, headers: header, cachePolicy: CachePolicy.useCache,
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

extension ServiceRequest {
    func clearCache(){
        apiClient.clearAllCache()
    }
    
}

