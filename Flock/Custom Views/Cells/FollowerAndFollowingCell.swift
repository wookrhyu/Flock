//
//  FollowerAndFollowingCell.swift
//  Flock
//
//  Created by Wook Rhyu on 6/10/21.
//

import UIKit

class FollowerAndFollowingCell: UITableViewCell {
    
    static let reuseID          = "FAFcell"
    let containerView           = UIView()
    let avatarImageView         = FAvatarImageView(frame: .zero)
    let usernameLabel           = FTitleLabel(textAlignment: .left, fontSize: 20, weight: .bold)
    let followerText            = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followingText           = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followerCount           = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followingCount          = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor             = .systemBackground
        configureContainerView()
        configureImageUsernameHandle()
        configureFollowerAndFollowing()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView() {

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor                       = .white
        containerView.layer.cornerRadius                    = 3.0
        containerView.dropShadow()
        
        NSLayoutConstraint.activate([
              containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
              containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
              containerView.heightAnchor.constraint(equalToConstant: 72),
              containerView.widthAnchor.constraint(equalToConstant: 377),
        ])

    }
    
    private func configureImageUsernameHandle() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
    }
    
    private func configureFollowerAndFollowing() {
        addSubview(followerText)
        addSubview(followingText)
        addSubview(followerCount)
        addSubview(followingCount)
        
        followerText.text = "followers"
        followingText.text = "following"
        
        NSLayoutConstraint.activate([
            followerText.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followerText.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 2),
            followerText.widthAnchor.constraint(equalToConstant: 75),
            followerText.heightAnchor.constraint(equalToConstant: 20),
            
            followerCount.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followerCount.leadingAnchor.constraint(equalTo: followerText.trailingAnchor, constant: 5),
            followerCount.widthAnchor.constraint(equalToConstant: 50),
            followerCount.heightAnchor.constraint(equalToConstant: 20),

            followingText.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followingText.leadingAnchor.constraint(equalTo: followerCount.trailingAnchor, constant: 10),
            followingText.widthAnchor.constraint(equalToConstant: 75),
            followingText.heightAnchor.constraint(equalToConstant: 20),

            followingCount.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followingCount.leadingAnchor.constraint(equalTo: followingText.trailingAnchor, constant: 5),
            followingCount.widthAnchor.constraint(equalToConstant: 50),
            followingCount.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setFollower(follower: FollowersData) {
        avatarImageView.downloadImage(fromURL: follower.profile_image_url)
        usernameLabel.text = follower.name
        followerCount.text = String(follower.public_metrics.followers_count)
        followingCount.text = String(follower.public_metrics.following_count)
    }
    
    func setFollowing(following: FollowingData) {
        avatarImageView.downloadImage(fromURL: following.profile_image_url)
        usernameLabel.text = following.name
        followerCount.text = String(following.public_metrics.followers_count)
        followingCount.text = String(following.public_metrics.following_count)
        
    }
    
    
}
