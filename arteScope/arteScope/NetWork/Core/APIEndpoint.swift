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
}
