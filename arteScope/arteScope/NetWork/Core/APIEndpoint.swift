//
//  APIEndpoint.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Alamofire

enum  APIEndpoint {
    
    // MARK: - Base URL
    static let baseURL = "https://collectionapi.metmuseum.org/"
    
    // MARK: - Department
    static let getDepartments: String = "public/collection/v1/departments"
    
    // MARK: - Search
    static let search = "public/collection/v1/search"
    
    // MARK: - Object
    static func objectDetails(id: Int) -> String {
        return "public/collection/v1/objects/\(id)"
    }
}
