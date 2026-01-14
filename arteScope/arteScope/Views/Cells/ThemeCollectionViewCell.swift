//
//  ThemeCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import UIKit

class ThemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var theme: Theme?
    
    var viewModel = ThemeViewModel()
    
    func setUp(with theme: Theme) {
        self.theme = theme
        titleLabel.text = theme.title
        imageView.image = UIImage(named: theme.image)
    }
}
