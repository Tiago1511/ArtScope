//
//  EmptyFavoriteView.swift
//  arteScope
//
//  Created by tiago on 26/01/2026.
//

import UIKit

class EmptyFavoriteView: UIView {

    static let indentifier: String = "EmptyFavoriteView"

    @IBOutlet weak var emptyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
        setup()
    }
    
    private func loadNib(){
        let view = Bundle.main.loadNibNamed(EmptyFavoriteView.indentifier, owner: self, options: nil)?.first as! UIView
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        addSubview(view)
    }
    
    //MARK: - Setup
    private func setup(){
        self.backgroundColor = .background
        emptyLabel.text = NSLocalizedString("emptyFavorites", comment: "")
    }
}
