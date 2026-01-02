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
        cachePolicy: CachePolicy = .ignoreCache,
        completionSuccess: @escaping (T) -> Void,
        completionFailure: @escaping (String) -> Void,
        completionTimeout: @escaping (String) -> Void
    ) {
        
        let urlRequestString = APIEndpoint.baseURL + endpoint
        
        guard let url = URL(string: urlRequestString) else {
            completionFailure(NSLocalizedString("invalidUrl", comment:""))
            return
        }
        
        var urlRequest = try! URLRequest(url: url, method: method)
        urlRequest.headers = headers ?? HTTPHeaders()
        urlRequest.timeoutInterval = timeout
        
        if let parameters {
            urlRequest = try! encoding.encode(urlRequest, with: parameters)
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
                let decoded = try decoder.decode(T.self, from: cached.data)
                completionSuccess(decoded)
                return
            } catch {
                // invalid cache, call service
                URLCache.shared.removeCachedResponse(for: urlRequest)
            }
        }
        
        // Request
        session.request(urlRequest)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                
                switch response.result {
                case .success(let data):
                    
                    // save in cache
                    if cachePolicy == .useCache, method == .get,
                       let httpResponse = response.response {
                        let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
                        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
                    }
                    
                    do {
                        let decoded = try self.decoder.decode(T.self, from: data)
                        completionSuccess(decoded)
                    } catch {
                        completionFailure(NSLocalizedString("errorProcessingData", comment: ""))
                    }
                    
                case .failure(let error):
                    if let urlError = error.asAFError?.underlyingError as? URLError, urlError.code == .timedOut {
                        completionTimeout(NSLocalizedString("timeOut", comment: ""))
                    } else {
                        completionFailure(error.localizedDescription)
                    }
                }
            }
    }
    
    // MARK: - Get Imagens
    func fetchImage(
        endpoint: String,
        headers: HTTPHeaders? = nil,
        completionSuccess: @escaping (UIImage) -> Void,
        completionFailure: @escaping (String) -> Void,
        completionTimeout: @escaping (String) -> Void
    ) {
        guard let url = URL(string: endpoint) else {
            completionFailure(NSLocalizedString("invalidUrl", comment:""))
            return
        }
        
        var urlRequest = try! URLRequest(url: url, method: HTTPMethod.get)
        urlRequest.headers = headers ?? HTTPHeaders()
        urlRequest.timeoutInterval = timeout
        
        session.request(url)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["image/jpeg", "image/png"])
            .responseData { response in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let image = UIImage(data: data),
                          let _ = response.response else {
                        completionFailure(NSLocalizedString("errorProcessingData", comment: ""))
                        return
                    }
                    completionSuccess(image)
                    
                case .failure(let error):
                    if let urlError = error.asAFError?.underlyingError as? URLError, urlError.code == .timedOut {
                        completionTimeout(NSLocalizedString("timeOut", comment: ""))
                    } else {
                        completionFailure(error.localizedDescription)
                    }
                }
            }
    }
}

//MARK: - Cache
extension APIClient {

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
}


