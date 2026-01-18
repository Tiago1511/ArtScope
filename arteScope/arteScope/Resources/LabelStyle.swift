//
//  LabelStyle.swift
//  arteScope
//
//  Created by tiago on 18/01/2026.
//

import UIKit

struct LabelStyle {
    let font: UIFont
    let color: UIColor
}


let descriptionLabelStyle: LabelStyle = LabelStyle(font: .systemFont(ofSize: 14, weight: .light), color: .labeldescription)
let titleLabelStyle: LabelStyle = LabelStyle(font: .systemFont(ofSize: 22, weight: .bold), color: .title)
let subtitleLabelStyle: LabelStyle = LabelStyle(font: .systemFont(ofSize: 18, weight: .bold), color: .subTitle)
