//
//  ThemeViewController.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class ThemesViewController: GenericViewController<ThemesViewModel> {
    
    static var storyboardID: String = "ThemesViewController"

    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("theme", comment:"")
    }
    
    private func setUp() {
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        themeCollectionView.register(ThemesCollectionViewCell.nib, forCellWithReuseIdentifier: ThemeTableViewCell.identifier)
        themeCollectionView.backgroundColor = .background
    }

}

extension ThemesViewController: UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.objects[indexPath.row]
        
        let cell: ThemesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemesCollectionViewCell.identifier, for: indexPath) as! ThemesCollectionViewCell
        
        let themeCollectionViewModel = ThemeCollectionViewModel()
        themeCollectionViewModel.object = item
        cell.viewModel.object = item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let item = viewModel.objects[indexPath.row]
        
        let viewController: ArtDetilsViewController = storyboard.instantiateViewController(withIdentifier: ArtDetilsViewController.storyboardID) as! ArtDetilsViewController
        
        viewController.viewModel.art = item
        
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    
}
