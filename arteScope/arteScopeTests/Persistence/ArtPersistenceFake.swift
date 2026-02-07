//
//  ArtPersistenceFake.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation

class ArtPersistenceFake: ArtPersistenceProtocol {
    private(set) var storage: [Object] = []

    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        storage.append(art)
        completion(.success(()))
    }
}

