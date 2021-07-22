//
//  FollowersAndFollowingView.swift
//  Flock
//
//  Created by Wook Rhyu on 6/22/21.
//

import UIKit

enum publicInfoType {
    case followers, following
}

class FollowersAndFollowingView: UIView {
    let titleLabel = FTitleLabel(textAlignment: .left, fontSize: 14, weight: .bold)
    let countLabel = FSecondaryTitleLabel(textAlignment: .left, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5),
            countLabel.heightAnchor.constraint(equalToConstant: 20),
            countLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(publicInfotype: publicInfoType, withCount count : Int){
        switch publicInfotype {
        case .followers:
            titleLabel.text                 = "Followers"
        case .following:
            titleLabel.text                 = "Following"
        }
        
        countLabel.text                     = String(count)
    }
}
