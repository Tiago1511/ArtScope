//
//  HomeViewController.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import UIKit

class HomeViewController: GenericViewController<HomeViewModel> {
    
    @IBOutlet weak var highlightCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("arteScope", comment:"")
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        highlightCollectionView.delegate = self
        highlightCollectionView.dataSource = self
        highlightCollectionView.register(UINib(nibName: "HighlightCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HighlightCollectionViewCell")
        highlightCollectionView.register(UINib(nibName: "ThemeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThemeCollectionViewCell")
        highlightCollectionView.register(UINib(nibName: "HomeHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeaderView")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        highlightCollectionView.collectionViewLayout = layout
        
        highlightCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        highlightCollectionView.backgroundColor = .secoundBackground
        
        Task {
            await viewModel.loadHome()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: - SetUp Bind
    override func setupBind() {
        super.setupBind()
        
        viewModel.reloadDepartment = { [weak self] () in
            DispatchQueue.main.async {
                self?.highlightCollectionView.reloadData()
            }
        }
        
        viewModel.reloadService = { [weak self] (title: String, message: String) in
            self?.showGenericAlert(
                title: title,
                message: message,
                onOk: { [weak self] () in
                    Task{
                        await self?.viewModel.loadHome()
                    }
                },
                onCancel: {
                    return
                }
            )
        }
        
    }

}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.homeSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.homeSections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 3.5, height: view.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView: HomeHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderView", for: indexPath) as! HomeHeaderView
        
        headerView.titleLabel.text = viewModel.homeSections[indexPath.section].headerTitle
        
        return headerView
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = viewModel.homeSections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .highlight(let highlight):
            let cell: HighlightCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightCollectionViewCell", for: indexPath) as! HighlightCollectionViewCell
            cell.setUp(with: highlight)
            return cell
        case .themes(let theme):
            let cell: ThemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCollectionViewCell", for: indexPath) as! ThemeCollectionViewCell
            cell.setUp(with: theme)
            return cell
        }
    }
}
