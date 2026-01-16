//
//  HomeHeaderView.swift
//  arteScope
//
//  Created by tiago on 13/01/2026.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    static var Identifier: String = "HomeHeaderView"
    
    static func nib() -> UINib {
        UINib(nibName: "HomeHeaderView", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
