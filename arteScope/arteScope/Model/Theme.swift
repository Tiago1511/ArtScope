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
}

var themes: [Theme] = [
    Theme(title: NSLocalizedString("landscapes", comment: ""), image: "landscape"),
    Theme(title: NSLocalizedString("portraits", comment: ""), image: "portrait"),
    Theme(title: NSLocalizedString("nature", comment: ""), image: "nature"),
    Theme(title: NSLocalizedString("flowers", comment: ""), image: "flowers"),
    Theme(title: NSLocalizedString("sea", comment: ""), image: "sea"),
    Theme(title: NSLocalizedString("animals", comment: ""), image: "animals")
]
