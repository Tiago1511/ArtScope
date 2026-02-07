//
//  ArtRepositoryProtocol.swift
//  arteScope
//
//  Created by tiago on 05/02/2026.
//

import Foundation
import CoreData

protocol ArtPersistenceProtocol {
    func saveArt(_ art: Object, completion: @escaping (Result<Void, Error>) -> Void)
    
}
