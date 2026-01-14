//
//  ServiceRequest.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

class ServiceRequest {
    
    // MARK: - Singleton
    static let shared = ServiceRequest()
    
    private var header: HTTPHeaders
    
    private var apiClient: APIClient = .shared
    
    init() {
        self.header = HTTPHeaders()
    }
    
    
    // MARK: - Getters
    
    /// Departement
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
    
    /// Highlights
    func getHighlights(
        completionSuccess:@escaping (Objects) -> Void,
        completionFailure:@escaping (String) -> Void,
        completionTimeout:@escaping (String) -> Void
    ){
        apiClient.request(
            endpoint: APIEndpoint.search,
            method: .get,
            parameters: [
                "isHighlight" : true,
                "q" : "*"
            ], headers: header, cachePolicy: CachePolicy.useCache,
            completionSuccess: { (highlights: Objects) in
                completionSuccess(highlights)
            },
            completionFailure: { errorMessage in
                completionFailure(errorMessage)
            },
            completionTimeout: { errorMessage in
                completionFailure(errorMessage)
            }
        )
    }
    
    /// Object
    func getObject(
        id: Int,
        completionSuccess: @escaping (Object) -> Void,
        completionFailure:@escaping (String) -> Void,
        completionTimeout:@escaping (String) -> Void
    ){
        apiClient.request(
            endpoint: APIEndpoint.objectDetails(id: id),
            method: .get,
            parameters: nil, headers: header, cachePolicy: CachePolicy.ignoreCache,
            completionSuccess: { (object: Object) in
                completionSuccess(object)
            },
            completionFailure: { errorMessage in
                completionFailure(errorMessage)
            },
            completionTimeout: { errorMessage in
                completionTimeout(errorMessage)
            }
        )
    }
    
    /// Image
    func getImage(
        url: String,
        completionSuccess: @escaping (UIImage) -> Void,
        completionFailure:@escaping (String) -> Void,
        completionTimeout:@escaping (String) -> Void
    ){
        apiClient.fetchImage(
            endpoint: url,
            headers: header,
            completionSuccess: { (image: UIImage) in
                completionSuccess(image)
            },
            completionFailure: { (errorMessage: String) in
                completionFailure(errorMessage)
            },
            completionTimeout: { (errorMessage: String) in
                completionTimeout(errorMessage)
            })
    }
        
}

extension ServiceRequest {
    func clearCache(){
        apiClient.clearAllCache()
    }
    
}

