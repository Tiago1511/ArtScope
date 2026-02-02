//
//  ThemesViewModel.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class ThemesViewModel: GenericViewModel, ViewModelFactory {
    
    static func make() -> ThemesViewModel {
        ThemesViewModel()
    }
    
    var object: Objects?
    var themes: [Object] = []
    
    var themeSelected: Theme?
    
    //MARK: - Clousers
    var reloadCollectionView: (() -> Void)?
    var reloadService: ((_ title: String, _ message: String) -> Void)?

    //MARK: - Service
    func loadTheme() async{
        Task {
            do {
                showLoading?()
                try await getTheme()
                reloadCollectionView?()
                hideLoading?()
                
            }catch {
                hideLoading?()
                reloadCollectionView?()
                hideLoading?()
                
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
    
    private func getTheme() async throws {
        
        object = try await service.getTheme(theme: themeSelected?.theme.rawValue ?? "")
        
        guard let highlight = object?.objectsIds else { return }
        
        await getThemeObjects(ids: highlight.prefix(10))
        
    }
    
    private func getThemeObjects(ids: ArraySlice<Int>) async {
        
        themes = []
        
        await withTaskGroup(of: Object?.self) { group in
            
            for id in ids {
                group.addTask {
                    try? await self.service.getObject(id: id)
                }
            }
            
            for await object in group {
                if let object{
                    themes.append(object)
                }
            }
        }
    }

}
