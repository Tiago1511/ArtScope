//
//  HomeViewModel.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import UIKit

class HomeViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> HomeViewModel {
            HomeViewModel()
    }
    
    public var departments: [Department] = []
    
    // MARK: - Closures
    var reloadDepartment: (() -> Void)?

    //MARK: - Services
    func getDepartment(){
        showLoading?()
        service.getDepartment(
            completionSuccess: { [weak self] (departmentResponse: DepartmentResponse) in
                self?.departments = departmentResponse.departments
                self?.hideLoading?()
            },
            completionFailure: { [weak self] (error) in
                self?.hideLoading?()
            },
            completionTimeout: { [weak self] (error) in
                self?.hideLoading?()
            }
        )
        
    }
}
