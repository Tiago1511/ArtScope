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
        artNameLabel.text = viewModel.art?.title
        dateLabel.text = viewModel.art?.artistBeginYear
        dimensionsLabel.text = viewModel.art?.dimensions
        artistNameLabel.text = viewModel.art?.artistName
        artistBioLabel.text = viewModel.art?.artistBio
    }

    @IBAction func favoriteButtonAction(_ sender: UIButton) {
    }
    
}
