//
//  arteScopeTests.swift
//  arteScopeTests
//
//  Created by tiago on 05/02/2026.
//

import XCTest
import CoreData

@testable import arteScope

class MockArtPersistence: ArtPersistenceProtocol {
    
    var shouldFail = false
    var savedArt: Object?
    var removedArt: Art?
    
    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else {
            savedArt = art
            completion(.success(()))
        }
    }
    
    func removeArt(_ art: Art, completion: @escaping (Result<Void, Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else {
            removedArt = art
            completion(.success(()))
        }
    }
    
}

