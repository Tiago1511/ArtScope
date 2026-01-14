//
//  HighlightCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import UIKit

class HighlightCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel = HighlightViewModel()
    
    func setUp(with highlight: Object) {
        self.viewModel.highlight = highlight
        titleLabel.text = highlight.title
        getImage()
    }
    
    func getImage(){
        viewModel.getImage(
            from: viewModel.highlight?.imageURL ?? "",
            completionSuccess: { [weak self](image: UIImage) in
                self?.imageView.image = image
        })
    }
    
}
