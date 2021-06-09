//
//  FAlertContainerView.swift
//  Flock
//
//  Created by Wook Rhyu on 6/8/21.
//

import UIKit

class FAlertContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 5
        layer.borderWidth     = 1
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
