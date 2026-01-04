//
//  AlertView.swift
//  arteScope
//
//  Created by tiago on 04/01/2026.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showGenericAlert( title: String = NSLocalizedString("error", comment: ""),
                           message: String,
                           okTitle: String = NSLocalizedString("OK", comment: ""),
                           cancelTitle: String = NSLocalizedString("cancel", comment: ""),
                           onOk: @escaping () -> Void,
                           onCancel: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            onOk()
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in onCancel?()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func showGenericAlert( title: String = NSLocalizedString("error", comment: ""),
                           message: String,
                           okTitle: String = NSLocalizedString("OK", comment: ""),
                           onOk: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            onOk()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
