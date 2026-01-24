//
//  ArtDetilsViewController.swift
//  arteScope
//
//  Created by tiago on 17/01/2026.
//

import UIKit

class ArtDetilsViewController: GenericViewController<ArtDetilsViewModel> {

    @IBOutlet weak var artUIImage: UIImageView!
    @IBOutlet weak var artDetailsLabel: UILabel!
    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
    @IBOutlet weak var artistTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistBioLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    static var storyboardID: String = "ArtDetilsViewController"
    
    
    override func viewDidLoad() {
        navBarTitle = viewModel.art?.title
        super.viewDidLoad()
        
        setup()
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.art?.imageURL ?? "")
                artUIImage.image = image
            } catch {
                artUIImage.isHidden = true
            }
        }
        
    }
    
    func setup() {
        setupArtDetails()
        setupArtistDetails()
    }
    
    private func setupArtDetails() {
        artDetailsLabel.setTheme(subtitleLabelStyle)
        artDetailsLabel.text = NSLocalizedString("artistDetails", comment: "")

        artNameLabel.setTheme(descriptionLabelStyle)
        artNameLabel.text = appendValueForLabel(title: NSLocalizedString("name", comment: ""), data: viewModel.art?.title ?? "")
        
        departmentLabel.setTheme(descriptionLabelStyle)
        departmentLabel.text = appendValueForLabel(title: NSLocalizedString("department", comment: ""), data:viewModel.art?.department ?? "")

        
        dimensionsLabel.setTheme(descriptionLabelStyle)
        dimensionsLabel.text = appendValueForLabel(title: NSLocalizedString("artDimensions", comment: ""), data:viewModel.art?.dimensions ?? "")
        
                
        if artNameLabel.text == "" && departmentLabel.text == "" && dimensionsLabel.text == "" {
            artDetailsLabel.isHidden = true
        }
    }
    
    private func setupArtistDetails() {
        artistTitleLabel.setTheme(subtitleLabelStyle)
        artistTitleLabel.text = NSLocalizedString("artistDetails", comment: "")
        
        artistNameLabel.setTheme(descriptionLabelStyle)
        artistNameLabel.text = appendValueForLabel(title: NSLocalizedString("name(s)", comment: ""), data:viewModel.art?.artistName ?? "")
        
        startDateLabel.setTheme(descriptionLabelStyle)
        startDateLabel.text = appendValueForLabel(title: NSLocalizedString("dateBirth", comment: ""), data:viewModel.art?.artistBeginYear ?? "")
        
        endDateLabel.setTheme(descriptionLabelStyle)
        endDateLabel.text = appendValueForLabel(title: NSLocalizedString("dateDeath", comment: ""), data:viewModel.art?.artistEndYear ?? "")
        
        artistBioLabel.setTheme(descriptionLabelStyle)
        artistBioLabel.text = appendValueForLabel(title: NSLocalizedString("bibliography", comment: ""), data:viewModel.art?.artistBio ?? "")
        
        if artistNameLabel.text == "" && startDateLabel.text == "" && endDateLabel.text == "" && artistBioLabel.text == "" {
            artistTitleLabel.isHidden = true
        }
    }

    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        viewModel.saveArtToFavorites()
    }
    
    private func appendValueForLabel(title: String, data: String) -> String{
        if data.isEmpty {
            return ""
        }
        
        return "\(title): \(data)"
        
    }
}
