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
    
    var departments: [Department] = []
    
    var highlights: Objects?
    var highlightObjects: [Object] = []
    
    var homeSections: [HomeSection] = []
    
    // MARK: - Closures
    var reloadDepartment: (() -> Void)?

    //MARK: - Services
    
    func getHighlights(){
        showLoading?()
        service.getHighlights(
            completionSuccess:{ [weak self] (response: Objects) in
                self?.highlights = response
                self?.fetchHighlightObjects(from: response.objectsIds)
            },
            completionFailure:{ [weak self] (error) in
                self?.hideLoading?()
            },
            completionTimeout:{ [weak self] (error) in
                self?.hideLoading?()
            }
            
        )
    }
    
    private func fetchHighlightObjects(from ids: [Int]) {

        guard !ids.isEmpty else {
            hideLoading?()
            return
        }

        highlightObjects = []

        let group = DispatchGroup()

        for id in ids.prefix(10) { // limita se quiseres
            group.enter()

            service.getObject(id: id,
                completionSuccess: { [weak self] (object: Object) in
                   // if object.isHighlight {
                        self?.highlightObjects.append(object)
                   // }
                    group.leave()
                },
                completionFailure: { _ in group.leave() },
                completionTimeout: { _ in group.leave() }
            )
        }

        group.notify(queue: .main) { [weak self] in
            self?.hideLoading?()
            self?.buildHomeSections()
        }
    }

    
    private func buildHomeSections(){
        if !highlightObjects.isEmpty {
            let section = HomeSection(
                headerTitle: NSLocalizedString("", comment: ""),
                items: highlightObjects.map() { highlightObject in
                    .highlight(highlightObject)
                })
            homeSections.append(section)
        }
        
        homeSections.append(
            HomeSection(headerTitle: NSLocalizedString("", comment: ""), items: themes.map() {
               .themes($0)
           } )
        )
        reloadDepartment?()
    }
}
