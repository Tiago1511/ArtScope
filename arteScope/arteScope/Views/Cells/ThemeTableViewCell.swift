//
//  ThemeCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 11/01/2026.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel = ThemeViewModel()
    
    static let identifier: String = "ThemeTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "ThemeTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        self.backgroundColor = .secoundBackground
        self.selectionStyle = .none
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        imgView.layer.cornerRadius = 10
        
    }
    
    func config(with theme: ThemeViewModel) {
        viewModel = theme
        titleLabel.text = viewModel.theme?.title ?? ""
        
        if let image = viewModel.theme?.image {
            imgView.image = UIImage(named: image)
        } else {
            imgView.image = UIImage(systemName: "xmark.circle")
        }
        
    }
}
