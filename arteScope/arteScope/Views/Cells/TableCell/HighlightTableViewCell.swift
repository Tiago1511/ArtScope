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
    @IBOutlet weak var imageMainView: UIView!
    
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
        titleLabel.setTheme(titleLabelStyle)
        artistNameLabel.setTheme(descriptionLabelStyle)
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
                imageMainView.isHidden = false
                imgView.image = image
            } catch {
                imageMainView.isHidden = true
            }
        }
    }
    
}
