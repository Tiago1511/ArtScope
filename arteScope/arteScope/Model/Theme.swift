//
//  Theme.swift
//  arteScope
//
//  Created by tiago on 10/01/2026.
//

import Foundation

struct Theme {
    let title: String
    let image: String
    let theme: ThemeEnum
}

var themes: [Theme] = [
    Theme(title: NSLocalizedString("landscapes", comment: ""), image: "landscape", theme: .landscapes),
    Theme(title: NSLocalizedString("portraits", comment: ""), image: "portrait", theme: .portraits),
    Theme(title: NSLocalizedString("nature", comment: ""), image: "nature", theme: .nature),
    Theme(title: NSLocalizedString("flowers", comment: ""), image: "flowers", theme: .flowers),
    Theme(title: NSLocalizedString("sea", comment: ""), image: "sea", theme: .sea),
    Theme(title: NSLocalizedString("animals", comment: ""), image: "animals", theme: .animals)
]

enum ThemeEnum: String {
    case landscapes = "landscapes"
    case portraits = "portraits"
    case nature = "nature"
    case flowers = "flowers"
    case sea = "sea"
    case animals = "animals"
}
