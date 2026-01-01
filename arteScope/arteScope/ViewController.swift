//
//  ViewController.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import UIKit

class ViewController: UIViewController {

    var departments: DepartmentResponse?
    var serviceRequest: ServiceRequest = ServiceRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceRequest.getDepartment(
            completionSuccess: { (departments: DepartmentResponse) in
                self.departments = departments
                
            }, completionFailure: { message in
                print(message)
                
            }, completionTimeout: { message in
                print(message)
            }
        )
    }


}

