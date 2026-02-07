//
//  ArtPersistenceSpy.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation

class ArtPersistenceSpy: ArtPersistenceProtocol {
    private(set) var saveArtCalled = false
    private(set) var receivedArt: Object?
    private(set) var removeArtCalled = false
    private(set) var receivedArtToRemove: Art?

    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        saveArtCalled = true
        receivedArt = art
        completion(.success(()))
    }
    
    func removeArt(_ art: Art, completion: @escaping (Result<Void, Error>) -> Void) {
        removeArtCalled = true
        receivedArtToRemove = art
        completion(.success(()))
    }
}
