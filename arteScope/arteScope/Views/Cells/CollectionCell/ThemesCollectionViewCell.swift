//
//  ThemesCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class ThemesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    static let identifier: String = "ThemesCollectionViewCell"
    
    static var nib: UINib {
        UINib(nibName: "ThemesCollectionViewCell", bundle: nil)
    }
    
    var viewModel = ThemeCollectionViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    //MARK: - SetUp
    func setUp() {
        self.backgroundColor = .background
        imgView.layer.cornerRadius = 10
        titleLabel.setTheme(titleLabelStyle)
        departmentLabel.setTheme(descriptionLabelStyle)
    }
    
    func config(_ object: ThemeCollectionViewModel) {
        viewModel = object
        titleLabel.text = viewModel.object?.title ?? ""
        departmentLabel.text = viewModel.object?.department ?? ""
        getImage()
    }
    
    func getImage(){
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.object?.imageURL ?? "")
                imgView.image = image
            } catch {
                imgView.isHidden = true
            }
        }
    }

}
