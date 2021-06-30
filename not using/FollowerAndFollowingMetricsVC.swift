//
//  FollowerAndFollowingMetricsVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/16/21.
//

import UIKit

class FollowerAndFollowingMetricsVC: UIViewController {
    
    let stackView       = UIStackView()
    let followerInfo    = FollowersAndFollowingView()
    let followingInfo   = FollowersAndFollowingView()
    
    var followers: FollowersData
    
    init(followers: FollowersData) {
        self.followers = followers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        //configureStackView()
        //configureUI()
    }
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(followerInfo)
        stackView.addArrangedSubview(followingInfo)
    }
    
    private func configureItems(){
        followerInfo.set(publicInfotype: .followers, withCount: followers.public_metrics.followers_count)
        followingInfo.set(publicInfotype: .following, withCount: followers.public_metrics.following_count)
    }
    
    private func configureUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    

}
