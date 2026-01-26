//
//  FavoriteHeaderView.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier: String = "FavoriteHeaderView"
    static func nib() -> UINib {
        UINib(nibName: "FavoriteHeaderView", bundle: nil)
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
