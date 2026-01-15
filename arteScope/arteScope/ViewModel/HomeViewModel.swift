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
    var reloadService: ((_ title: String, _ message: String) -> Void)?

    //MARK: - Services
    func loadHome() async{
        Task {
            do {
                showLoading?()
                try await getHighlights()
                buildHomeSections()
                hideLoading?()
                reloadDepartment?()
                
            } catch {
        
                buildHomeSections()
                hideLoading?()
                reloadDepartment?()
                
                switch error as? NetworkError {
                case .invalidURL, .decoding:
                    reloadService?(NSLocalizedString("error", comment: ""), NSLocalizedString("errorProcessingData", comment: ""))
                    break
                    
                case .timeout:
                    reloadService?(NSLocalizedString("error", comment: ""), NSLocalizedString("errorProcessingData", comment: "" ))
                    break
                    
                case .noInternet:
                    reloadService?(NSLocalizedString("noInternet", comment: ""), NSLocalizedString("checkConnection", comment: ""))
                    break
                    
                case .server(let message):
                    reloadService?(NSLocalizedString("error", comment: ""), message)
                    break
                    
                default:
                    showAlert?(NSLocalizedString("serviceError", comment: ""))
                    break
                }
                                
            }
        }
    }

    
    private func getHighlights() async throws {
        
        let ojects = try await service.getHighlights()
        highlights = ojects
        
        guard let highlight = highlights?.objectsIds else { return }
        
        // get 10 elements
        await fetchHighlightObjects(ids: highlight.prefix(10))
        
        
    }
    
    private func fetchHighlightObjects(ids: ArraySlice<Int>) async {
        
        highlightObjects = []
        
        await withTaskGroup(of: Object?.self) { group in
            
            for id in ids {
                group.addTask {
                    try? await self.service.getObject(id: id)
                }
            }
            
            for await object in group {
                if let object{
                    highlightObjects.append(object)
                }
            }
        }
    }

    
    private func buildHomeSections(){
        
        homeSections = []
        
        if !highlightObjects.isEmpty {
            let section = HomeSection(
                headerTitle: NSLocalizedString("highlight", comment: ""),
                items: highlightObjects.map() { highlightObject in
                    .highlight(highlightObject)
                })
            homeSections.append(section)
        }
        
        homeSections.append(
            HomeSection(headerTitle: NSLocalizedString("theme", comment: ""), items: themes.map() {
               .themes($0)
           } )
        )
    }
}
