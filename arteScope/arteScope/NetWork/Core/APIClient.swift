//
//  APIClient.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

final class APIClient {
    
    // MARK: - Singleton
    static let shared = APIClient()
    
    // MARK: - Base URL
    private let baseURL = "https://collectionapi.metmuseum.org/"
    
    // MARK: - Session (URLCache)
    private let session: Session
    
    private init() {
        let cacheSizeMemory = 50 * 1024 * 1024 // 50 MB
        let cacheSizeDisk = 100 * 1024 * 1024 // 100 MB
        
        let cache = URLCache(
            memoryCapacity: cacheSizeMemory,
            diskCapacity: cacheSizeDisk,
            diskPath: "url_cache"
        )
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 30.0
        
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - Generic Request
    func request<T: Decodable>(
        endpoint: String,
        cachePolicy: APICachePolicy = .noCache,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: Parameters? = nil,
        completionSuccess: @escaping (T) -> Void,
        completionFailure: @escaping (String) -> Void,
        completionTimeout: @escaping (String) -> Void
    ) {
        let url = baseURL + endpoint
        
        guard let url = URL(string: url) else {
            completionFailure(NSLocalizedString("errorProcessingData", comment:""))
            return
        }
               
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = cachePolicy.urlPolicy
        
        if let parameters = parameters {
            do {
                let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                completionFailure(NSLocalizedString("errorProcessingData", comment: ""))
                return
            }
        }
        
        session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completionSuccess(data)
                
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
        urlString: String,
        completionSuccess: @escaping (UIImage) -> Void,
        completionFailure: @escaping (String) -> Void,
        completionTimeout: @escaping () -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completionFailure(NSLocalizedString("invalidUrl", comment:""))
            return
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData

        session.request(request)
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
                        completionTimeout()
                    } else {
                        completionFailure(error.localizedDescription)
                    }
                }
            }
    }
}

