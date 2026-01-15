//
//  APIClient.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

// MARK: - ENUM
nonisolated enum CachePolicy {
    case useCache
    case ignoreCache
}

nonisolated enum NetworkError: Error {
    case invalidURL
    case timeout
    case noInternet
    case decoding
    case server(message: String)
    case unknown
}

@MainActor
final class APIClient {
    
    // MARK: - Singleton
    static let shared = APIClient()
    
    // MARK: - Session (URLCache)
    private let session: Session
    
    // MARK: - JSON decoder
    private let decoder = JSONDecoder()
    
    private let timeout: TimeInterval = 60.0
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .useProtocolCachePolicy
        session = Session(configuration: configuration)
    }
    
    //MARK: - Requests
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .ignoreCache
    )  async throws -> T{
        
        let urlRequestString = APIEndpoint.baseURL + endpoint
        
        guard let url = URL(string: urlRequestString) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = try! URLRequest(url: url, method: method)
        urlRequest.headers = headers ?? HTTPHeaders()
        urlRequest.timeoutInterval = timeout
        
        if let parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters)
        }
        
        // Definir política de cache de acordo com parâmetro
        switch cachePolicy {
        case .useCache:
            urlRequest.cachePolicy = .returnCacheDataElseLoad
        case .ignoreCache:
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        }
        
        // validade have cache for gets
        if cachePolicy == .useCache && method == .get,
           // have data for this request
           let cached = URLCache.shared.cachedResponse(for: urlRequest) {
            do {
                return try decoder.decode(T.self, from: cached.data)
            } catch {
                // invalid cache, call service
                URLCache.shared.removeCachedResponse(for: urlRequest)
            }
        }
        
        do{
            // Request
            let data = try await session
                .request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .serializingData()
                .value
            
            // Save cache
            if cachePolicy == .useCache,
               method == .get,
               let _ = session.session.configuration.urlCache,
               let httpResponse = HTTPURLResponse(url: url,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil) {
                
                let cachedResponse = CachedURLResponse(
                    response: httpResponse,
                    data: data
                )
                URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
            }
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding
            }
        } catch {
            throw mapError(error)
        }
    }
    
    // MARK: - Get Imagens
    func fetchImage(
        endpoint: String,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .ignoreCache
    ) async throws -> UIImage {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = try! URLRequest(url: url, method: HTTPMethod.get)
        urlRequest.headers = headers ?? HTTPHeaders()
        urlRequest.timeoutInterval = timeout
        
        switch cachePolicy {
        case .useCache:
            urlRequest.cachePolicy = .returnCacheDataElseLoad
        case .ignoreCache:
            urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        }
        
        if cachePolicy == .useCache,
           let cached = URLCache.shared.cachedResponse(for: urlRequest),
           let image = UIImage(data: cached.data) {
            return image
        }
        
        do {
            let data = try await session.request(url)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["image/jpeg", "image/png"])
                .serializingData()
                .value
            
            if let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ) {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkError.decoding
            }
            
            return image
            
        } catch {
            throw mapError(error)
        }
    }
    
    //MARK: - Cache
    
    // clear all cache
    func clearAllCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    // clear endpoint cache
    func clearCache(for endpoint: String, method: HTTPMethod = .get) {
        let urlRequestString = APIEndpoint.baseURL + endpoint
        
        guard let url = URL(string: urlRequestString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLCache.shared.removeCachedResponse(for: request)
    }
    
    // MARK: - Map Error
    private func mapError(_ error: Error) -> NetworkError {
        
        if let afError = error.asAFError {
            
            if let urlError = afError.underlyingError as? URLError {
                switch urlError.code {
                case .timedOut:
                    return .timeout
                case .notConnectedToInternet:
                    return .noInternet
                default:
                    return .unknown
                }
            }
            
            return .server(message: afError.localizedDescription)
        }
        
        return .unknown
    }
    
}
