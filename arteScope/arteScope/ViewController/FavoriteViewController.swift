//
//  FavoriteViewController.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteViewController: GenericViewController<FavoritesViewModel> {
    
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(FavoriteCollectionViewCell.nib, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        favoriteCollectionView.backgroundColor = .background
    }
    
    //MARK: - SetUp Bind
    override func setupBind() {
        super.setupBind()
        viewModel.reloadCollection = { [weak self] () in
            DispatchQueue.main.async{
                self?.favoriteCollectionView.reloadData()
            }
        }
    }
    
    
}


extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavoriteHeaderView.reuseIdentifier, for: indexPath) as! FavoriteHeaderView
        
        headerView.titleLabel.text = NSLocalizedString("favorites", comment: "")
        
        return headerView
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        let favorite = self.viewModel.favorites[indexPath.row]
        
        let favoriteViewModel = FavoriteViewModel ()
        favoriteViewModel.art = favorite
        cell.config(with: favoriteViewModel)
        
        return cell
    }
    
}
