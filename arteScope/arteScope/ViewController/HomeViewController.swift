//
//  HomeViewController.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import UIKit

class HomeViewController: GenericViewController<HomeViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        navBarTitle = NSLocalizedString("arteScope", comment:"")
        // Do any additional setup after loading the view.
    }
    
    //MARK: - SetUp Bind
    func setUpBind() {
        viewModel.reloadDepartment = { () in
            
        }
        
        //viewModel.sho
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
