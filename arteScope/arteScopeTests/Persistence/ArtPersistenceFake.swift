//
//  ArtPersistenceFake.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation

class ArtPersistenceFake: ArtPersistenceProtocol {
    private(set) var storage: [Object] = []
    private(set) var artStorage: [Art] = []

    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        storage.append(art)
        completion(.success(()))
    }
    
    func removeArt(_ art: Art, completion: @escaping (Result<Void, Error>) -> Void) {
        artStorage.append(art)
        completion(.success(()))
    }
}

