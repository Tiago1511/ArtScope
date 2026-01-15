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
    
    private var task: Task<Void, Never>?
    var viewModel = HighlightViewModel()
    
    func setUp(with highlight: Object) {
        self.viewModel.highlight = highlight
        titleLabel.text = highlight.title
        getImage()
    }
    
    func getImage(){
        task = Task{
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
