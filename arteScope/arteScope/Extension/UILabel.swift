//
//  File.swift
//  arteScope
//
//  Created by tiago on 18/01/2026.
//

import Foundation
import UIKit

extension UILabel {
    
    func setTheme(_ labelStyle: LabelStyle) {
        font = labelStyle.font
        textColor = labelStyle.color
    }
}
