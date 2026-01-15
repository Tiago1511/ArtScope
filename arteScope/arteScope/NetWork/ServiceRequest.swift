//
//  ServiceRequest.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

final class ServiceRequest {
    
    // MARK: - Singleton
    static let shared = ServiceRequest()
    
    private var header: HTTPHeaders
    
    private var apiClient: APIClient = .shared
    
    init() {
        self.header = HTTPHeaders()
    }
    
    
    // MARK: - Getters
    
    /// Departement
    func getDepartment() async throws -> DepartmentResponse {
        try await apiClient.request(
            endpoint: APIEndpoint.getDepartments,
            method: .get,
            parameters: nil,
            headers: header,
            cachePolicy: CachePolicy.useCache,
        )
        
    }
    
    /// Highlights
    func getHighlights() async throws -> Objects {
        try await apiClient.request(
            endpoint: APIEndpoint.search,
            method: .get,
            parameters: [
                "isHighlight" : true,
                "q" : "*"
            ],
            headers: header,
            cachePolicy: CachePolicy.useCache
        )
    }
    
    /// Object
    func getObject( id: Int) async throws -> Object{
        try await apiClient.request(
            endpoint: APIEndpoint.objectDetails(id: id),
            method: .get,
            parameters: nil,
            headers: header,
            cachePolicy: CachePolicy.ignoreCache,
        )
    }
    
    /// Image
    func getImage(url: String) async throws -> UIImage {
        try await apiClient.fetchImage(
            endpoint: url,
            headers: header,
            cachePolicy: CachePolicy.ignoreCache
            )
    }
        
}

extension ServiceRequest {
    func clearCache(){
        apiClient.clearAllCache()
    }
    
}

