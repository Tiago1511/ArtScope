//
//  APICache.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation

enum APICachePolicy {
    case noCache
    case useCache
    case reloadIgnoringCache
    
    var urlPolicy: URLRequest.CachePolicy {
        switch self {
        case .noCache:
            return .reloadIgnoringLocalCacheData
        case .useCache:
            return .useProtocolCachePolicy
        case .reloadIgnoringCache:
            return .reloadRevalidatingCacheData
        }
    }
}
