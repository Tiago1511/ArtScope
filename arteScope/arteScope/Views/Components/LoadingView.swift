//
//  LoadingView.swift
//  arteScope
//
//  Created by tiago on 03/01/2026.
//

import UIKit

class LoadingView: UIView {
    
    private let loading = UIActivityIndicatorView(style: .large)
    private var didSetupConstraints = false
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .white
        self.isUserInteractionEnabled = true
        
        self.addSubview(loading)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil, !didSetupConstraints else { return }
        didSetupConstraints = true
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: centerYAnchor),
            loading.widthAnchor.constraint(equalToConstant: 50),
            loading.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func startLoading(){
        self.loading.startAnimating()
    }
    
    func stopLoading(){
        self.loading.stopAnimating()
    }
}
