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

    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        saveArtCalled = true
        receivedArt = art
        completion(.success(()))
    }
}
