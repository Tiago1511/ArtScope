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
    
    var viewModel = ThemeViewModel()
    
    static let identifier: String = "ThemeCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "ThemeCollectionViewCell", bundle: nil)
    }
    
    func setUp(with theme: ThemeViewModel) {
        viewModel = theme
        titleLabel.text = viewModel.theme?.title ?? ""
        
        if let image = viewModel.theme?.image {
            imageView.image = UIImage(named: image)
        } else {
            imageView.image = UIImage(systemName: "xmark.circle")
        }
        
    }
}
