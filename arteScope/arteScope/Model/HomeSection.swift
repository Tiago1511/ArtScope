//
//  HomeSection.swift
//  arteScope
//
//  Created by tiago on 10/01/2026.
//

import Foundation

struct HomeSection {
    let headerTitle: String
    let items: [HomeSectionItem]
}

enum HomeSectionItem {
    case highlight(Object)
    case themes(Theme)
}
