//
//  FavoriteHeaderView.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteHeaderView: UICollectionReusableView {
    
    static var reuseIdentifier: String = "FavoriteHeaderView"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
