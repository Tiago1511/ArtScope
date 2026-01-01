//
//  ArtWork.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

struct Department: Codable {
    var departmentId: Int
    var displayName: String
}

struct DepartmentResponse: Decodable {
    let departments: [Department]
}
