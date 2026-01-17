//
//  HomeViewController.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import UIKit

let tableViewHeaderHeight: CGFloat = 40
let tableViewCellHeight: CGFloat = 100

class HomeViewController: GenericViewController<HomeViewModel> {
    
    @IBOutlet weak var highlightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("arteScope", comment:"")
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        highlightTableView.delegate = self
        highlightTableView.dataSource = self
        
        highlightTableView.backgroundColor = .background
        
        highlightTableView.register(HighlightTableViewCell.nib(), forCellReuseIdentifier: HighlightTableViewCell.identifier)
        highlightTableView.register(ThemeTableViewCell.nib(), forCellReuseIdentifier: ThemeTableViewCell.identifier)
        highlightTableView.register(HomeHeaderView.nib(), forHeaderFooterViewReuseIdentifier: HomeHeaderView.identifier)
                
        highlightTableView.separatorStyle = .none
        highlightTableView.layer.cornerRadius = 10
        highlightTableView.layer.masksToBounds = true
        
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
                self?.highlightTableView.reloadData()
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

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.homeSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.homeSections[section].items.count
        
    }
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HomeHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderView.identifier) as! HomeHeaderView
        
        headerView.titleLabel.text = viewModel.homeSections[section].headerTitle
        
        return headerView
    }
    
    
    // data
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.homeSections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .highlight(let highlight):
            let cell: HighlightTableViewCell = tableView.dequeueReusableCell(withIdentifier: HighlightTableViewCell.identifier, for: indexPath) as! HighlightTableViewCell
            
            let highlightViewModel = HighlightViewModel()
            highlightViewModel.highlight = highlight
            
            cell.config(with: highlightViewModel)
            return cell
            
        case .themes(let theme):
            let cell: ThemeTableViewCell = tableView.dequeueReusableCell(withIdentifier: ThemeTableViewCell.identifier, for: indexPath) as! ThemeTableViewCell
            
            let themeViewModel = ThemeViewModel()
            themeViewModel.theme = theme
            
            cell.config(with: themeViewModel)
            return cell
        }
    }
}
