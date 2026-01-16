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

    static let identifier: String = "HighlightCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "HighlightCollectionViewCell", bundle: nil)
    }
    
    func setUp(with highlight: HighlightViewModel) {
        viewModel = highlight
        titleLabel.text = viewModel.highlight?.title ?? ""
        getImage()
    }
    
    func getImage(){
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.highlight?.imageURL ?? "")
                imageView.image = image
            } catch {
                imageView.image = UIImage(systemName: "xmark.circle")
                imageView.tintColor = .background
            }
        }
    }
    
}
