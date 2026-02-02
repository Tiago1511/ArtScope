//
//  SplashScreenViewController.swift
//  arteScope
//
//  Created by tiago on 04/01/2026.
//

import UIKit

class SplashScreenViewController: GenericViewController<SplashScreenViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsNavigationBar = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.checkInternetConnection()
    }

    
    //MARK: - SetUp Bind
    override func setupBind() {
        super.setupBind()
        viewModel.connectToInternet = { [weak self] in
            self?.showNoInternetAlert()
        }
        viewModel.nextStep = { [weak self] in
            self?.nextStep()
        }
    }
    
    private func showNoInternetAlert() {
        let alertNetInfo = UIAlertController()
        
        alertNetInfo.showGenericAlert(
            title: NSLocalizedString("noInternet", comment: ""),
            message: NSLocalizedString("checkConnection", comment: ""),
            onOk: { () in
                return
            }
            
        )
        
    }
    
    private func nextStep() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
