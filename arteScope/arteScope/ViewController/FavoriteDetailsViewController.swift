//
//  FavoriteDetailsViewController.swift
//  arteScope
//
//  Created by tiago on 25/01/2026.
//

import UIKit

class FavoriteDetailsViewController: GenericViewController<FavoriteDetailsViewModel> {
    
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
    
    @IBOutlet weak var removeFavoriteButton: UIButton!
    
    static var storyboardID: String = "FavoriteDetailsViewController"

    override func viewDidLoad() {
        navBarTitle = viewModel.art?.artTitle ?? ""
        super.viewDidLoad()

        setup()
        Task{
            do {
                let image = try await viewModel.getImage(from: viewModel.art?.artImage ?? "")
                artUIImage.image = image
            } catch {
                artUIImage.isHidden = true
            }
        }
        
    }
    
    //MARK: - Binding
    override func setupBind() {
        super.setupBind()
        
        viewModel.showSuccessAlert = { [weak self] (title: String, message: String) in
            DispatchQueue.main.async {
                self?.showGenericAlert(
                    title: title,
                    message: message,
                    onOk: { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                )
            }
        }
    }
    
    //MARK: - Setup
    func setup() {
        removeFavoriteButton.setTitle(NSLocalizedString("removeFavorite", comment: ""), for: .normal)
        setupArtDetails()
        setupArtistDetails()
    }
    
    private func setupArtDetails() {
        artDetailsLabel.setTheme(subtitleLabelStyle)
        artDetailsLabel.text = NSLocalizedString("artDetails", comment: "")

        artNameLabel.setTheme(descriptionLabelStyle)
        artNameLabel.text = appendValueForLabel(title: NSLocalizedString("name", comment: ""), data: viewModel.art?.artTitle ?? "")
        
        departmentLabel.setTheme(descriptionLabelStyle)
        departmentLabel.text = appendValueForLabel(title: NSLocalizedString("department", comment: ""), data:viewModel.art?.artDepartment ?? "")

        
        dimensionsLabel.setTheme(descriptionLabelStyle)
        dimensionsLabel.text = appendValueForLabel(title: NSLocalizedString("artDimensions", comment: ""), data:viewModel.art?.artDimensions ?? "")
        
                
        if artNameLabel.text == "" && departmentLabel.text == "" && dimensionsLabel.text == "" {
            artDetailsLabel.isHidden = true
        }
    }
    
    private func setupArtistDetails() {
        artistTitleLabel.setTheme(subtitleLabelStyle)
        artistTitleLabel.text = NSLocalizedString("artistDetails", comment: "")
        
        artistNameLabel.setTheme(descriptionLabelStyle)
        artistNameLabel.text = appendValueForLabel(title: NSLocalizedString("name(s)", comment: ""), data:viewModel.art?.artist?.artistName ?? "")
        
        startDateLabel.setTheme(descriptionLabelStyle)
        startDateLabel.text = appendValueForLabel(title: NSLocalizedString("dateBirth", comment: ""), data:viewModel.art?.artist?.dateBirth ?? "")
        
        endDateLabel.setTheme(descriptionLabelStyle)
        endDateLabel.text = appendValueForLabel(title: NSLocalizedString("dateDeath", comment: ""), data:viewModel.art?.artist?.dateDeath ?? "")
        
        artistBioLabel.setTheme(descriptionLabelStyle)
        artistBioLabel.text = appendValueForLabel(title: NSLocalizedString("bibliography", comment: ""), data:viewModel.art?.artist?.bibliography ?? "")
        
        if artistNameLabel.text == "" && startDateLabel.text == "" && endDateLabel.text == "" && artistBioLabel.text == "" {
            artistTitleLabel.isHidden = true
        }
    }

    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        viewModel.removeArtToFavorites()
    }
    
    private func appendValueForLabel(title: String, data: String) -> String{
        if data.isEmpty {
            return ""
        }
        
        return "\(title): \(data)"
        
    }

}
