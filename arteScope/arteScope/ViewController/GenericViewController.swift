//
//  GenericViewController.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import Foundation
import UIKit

class GenericViewController<VM>: UIViewController
where VM: GenericViewModel & ViewModelFactory,
        VM.ViewModel == VM
{
    
    lazy var viewModel: VM = {
            VM.make()
        }()

    private var loadingView: LoadingView?
    
    var showsNavigationBar: Bool = true
    
    var navBarTitle: String? {
        didSet { self.title = navBarTitle }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupNavBar()
        setupBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!showsNavigationBar, animated: animated)
    }
    
    //MARK: - SetUp
    func setupNavBar() {
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.configureWithOpaqueBackground()
        navBarAppearence.backgroundColor = UIColor.navBarBackground
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.navBarTitle]
        navigationItem.standardAppearance = navBarAppearence
        navigationItem.scrollEdgeAppearance = navBarAppearence
        navigationController?.navigationBar.tintColor = UIColor.navBarTitle
    }
    
    //MARK: - SetUp Bind
    func setupBind() {
        viewModel.showLoading = { [weak self] in // uso o [weak self] pois como estou a usar um clousere que é executada depois de um tempo, pois não tenho a garantia que a instancia ainda vai estar ativa
            self?.showLoadingView()
        }
        
        viewModel.hideLoading = { [weak self] in
            self?.hideLoadingView()
        }
    }
    
}

//MARK: - Loading
extension GenericViewController {
    
    func showLoadingView() {
        
        guard loadingView == nil else { return }
        
        let loading = LoadingView(frame: self.view.bounds)
        loading.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loading.topAnchor.constraint(equalTo: self.view.topAnchor),
            loading.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        loadingView = loading
        loading.startLoading()
    }
    
    // I prefere removing the loading view because:
    // - it is removed from the view hierarchy
    // - it is a simple view, so recreating it is fast
    // - it minimizes the risk of layout or interaction issues
    func hideLoadingView() {
        loadingView?.stopLoading()
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}
