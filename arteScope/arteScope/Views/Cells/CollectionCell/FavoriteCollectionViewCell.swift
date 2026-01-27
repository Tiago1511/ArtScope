//
//  FavoriteCollectionViewCell.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    static let identifier: String = "FavoriteCollectionViewCell"
    
    static var nib: UINib {
        return UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
    }
    
    var viewModel = FavoriteViewModel()
    
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
    
    func config(with highlight: FavoriteViewModel) {
        viewModel = highlight
        titleLabel.text = viewModel.art?.artTitle ?? ""
        departmentLabel.text = viewModel.art?.artDepartment ?? ""
        getImage()
    }
    
    func getImage(){
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.art?.artImage ?? "")
                imgView.image = image
            } catch {
                imgView.isHidden = true
            }
        }
    }
}
