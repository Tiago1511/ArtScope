//
//  ArtDetilsViewController.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit

class ArtDetilsViewController: GenericViewController<ArtDetilsViewModel> {

    @IBOutlet weak var artUIImage: UIImageView!
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistBioLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!
    
    static var storyboardID: String = "ArtDetilsViewController"
    
    
    override func viewDidLoad() {
        navBarTitle = viewModel.art?.title
        super.viewDidLoad()
        
        Task{
            artUIImage.image = try await viewModel.getImage(from: viewModel.art?.imageURL ?? "")
        }
        
        setUp()
    }
    
    func setUp() {
        artNameLabel.setTheme(descriptionLabelStyle)
        artNameLabel.text = appendValueForLabel(title: NSLocalizedString("name", comment: ""), data: viewModel.art?.title ?? "")
        
        dateLabel.setTheme(descriptionLabelStyle)
        dateLabel.text = appendValueForLabel(title: NSLocalizedString("date", comment: ""), data:viewModel.art?.artistBeginYear ?? "")
        
        dimensionsLabel.setTheme(descriptionLabelStyle)
        dimensionsLabel.text = appendValueForLabel(title: NSLocalizedString("artDimensions", comment: ""), data:viewModel.art?.dimensions ?? "")
        
        artistTitleLabel.setTheme(subtitleLabelStyle)
        artistTitleLabel.text = NSLocalizedString("artistDetails", comment: "")
        
        artistNameLabel.setTheme(descriptionLabelStyle)
        artistNameLabel.text = appendValueForLabel(title: NSLocalizedString("name(s)", comment: ""), data:viewModel.art?.artistName ?? "")
        
        artistBioLabel.setTheme(descriptionLabelStyle)
        artistBioLabel.text = appendValueForLabel(title: NSLocalizedString("bibliography", comment: ""), data:viewModel.art?.artistBio ?? "")
    }

    @IBAction func favoriteButtonAction(_ sender: UIButton) {
    }
    
    private func appendValueForLabel(title: String, data: String) -> String{
        if data.isEmpty {
            return ""
        }
        
        return "\(title): \(data)"
        
    }
}
