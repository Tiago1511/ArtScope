//
//  HighlightCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import UIKit

class HighlightTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel = HighlightViewModel()

    static let identifier: String = "HighlightTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "HighlightTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    //MARK: - SetUp
    func setUp() {
        self.backgroundColor = .secoundBackground
        self.selectionStyle = .none
        imgView.layer.cornerRadius = 10
    }
    
    func config(with highlight: HighlightViewModel) {
        viewModel = highlight
        titleLabel.text = viewModel.highlight?.title ?? ""
        artistNameLabel.text = viewModel.highlight?.artistName ?? ""
        getImage()
    }
    
    func getImage(){
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.highlight?.imageURL ?? "")
                imgView.image = image
            } catch {
                imgView.image = UIImage(systemName: "xmark.circle")
                imgView.tintColor = .background
            }
        }
    }
    
}
