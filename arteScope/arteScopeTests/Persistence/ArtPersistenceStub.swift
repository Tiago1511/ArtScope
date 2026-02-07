//
//  ArtPersistenceStub.swift
//  arteScopeTests
//
//  Created by tiago on 07/02/2026.
//

import Foundation

class ArtPersistenceStub: ArtPersistenceProtocol {
    var result: Result<Void, Error> = .success(())

    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(result)
    }
}
