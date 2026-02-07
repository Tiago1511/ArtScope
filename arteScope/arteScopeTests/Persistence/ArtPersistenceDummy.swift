//
//  ArtPersistenceDummy.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation

class ArtPersistenceDummy: ArtPersistenceProtocol {
    func saveArt(_ art: Object, completion: @escaping (Result<Void, any Error>) -> Void) {
        fatalError("Dummy should not be used")
    }
}
