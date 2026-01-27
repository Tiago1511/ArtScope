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
    
    var emptyView: EmptyFavoriteView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("theme", comment:"")
        setUp()
    }
    
    //MARK: - SetUp
    private func setUp() {
        themeCollectionView.delegate = self
        themeCollectionView.dataSource = self
        themeCollectionView.register(ThemesCollectionViewCell.nib, forCellWithReuseIdentifier: ThemesCollectionViewCell.identifier)
        themeCollectionView.backgroundColor = .background
        
        Task {
            await viewModel.loadTheme()
        }
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
    
    
    //MARK: - Binding
    override func setupBind() {
        super.setupBind()
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.setupEmptyView()
                self.emptyView?.isHidden = !self.viewModel.themes.isEmpty
                self.themeCollectionView.reloadData()
            }
        }
    }

}

extension ThemesViewController: UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.themes[indexPath.row]
        
        let cell: ThemesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemesCollectionViewCell.identifier, for: indexPath) as! ThemesCollectionViewCell
        
        let themeCollectionViewModel = ThemeCollectionViewModel()
        themeCollectionViewModel.object = item
        cell.config(themeCollectionViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let item = viewModel.themes[indexPath.row]
        
        let viewController: ArtDetilsViewController = storyboard.instantiateViewController(withIdentifier: ArtDetilsViewController.storyboardID) as! ArtDetilsViewController
        
        viewController.viewModel.art = item
        
        navigationController?.pushViewController(viewController, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return CGSize(width: collectionView.frame.width / 4.5, height: collectionView.frame.width / 4.5)
        }
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}
