//
//  FavoriteViewController.swift
//  arteScope
//
//  Created by tiago on 24/01/2026.
//

import UIKit

class FavoriteViewController: GenericViewController<FavoritesViewModel> {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    var emptyView: EmptyFavoriteView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("favorites", comment:"")
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
    
    private func setupEmptyView() {
        guard emptyView == nil else { return }
        let empty = EmptyFavoriteView()
        empty.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(empty)
        
        NSLayoutConstraint.activate([
            empty.topAnchor.constraint(equalTo: view.topAnchor),
            empty.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            empty.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            empty.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        emptyView = empty
        
    }
    
    //MARK: - SetUp Bind
    override func setupBind() {
        super.setupBind()
        viewModel.reloadCollection = { [weak self] () in
            DispatchQueue.main.async{
                guard let self = self else { return }
                
                self.setupEmptyView()
                self.emptyView?.isHidden = !self.viewModel.favorites.isEmpty
                self.favoriteCollectionView.reloadData()
            }
        }
    }
    
    
}


extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favorites.count
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize{
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return CGSize(width: collectionView.frame.width / 4.5, height: collectionView.frame.width / 4.5)
        }
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let favorite = self.viewModel.favorites[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: FavoriteDetailsViewController = storyboard.instantiateViewController(withIdentifier: FavoriteDetailsViewController.storyboardID) as! FavoriteDetailsViewController
        viewController.viewModel.art = favorite
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //spleat
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }


}
