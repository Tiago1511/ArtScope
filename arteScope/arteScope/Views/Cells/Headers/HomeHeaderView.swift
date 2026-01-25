//
//  HomeHeaderView.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static var identifier: String = "HomeHeaderView"
    
    static func nib() -> UINib {
        UINib(nibName: "HomeHeaderView", bundle: nil)
    }
}
