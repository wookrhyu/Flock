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
    let usernameLabel           = FTitleLabel(textAlignment: .left, fontSize: 20)
    let twitterhandle           = FSecondaryTitleLabel(textAlignment: .left, fontSize: 16)
    let followerText            = FTitleLabel(textAlignment: .left, fontSize: 16)
    let followingText           = FTitleLabel(textAlignment: .left, fontSize: 16)
    let followerCount           = FTitleLabel(textAlignment: .left, fontSize: 16)
    let followingCount          = FTitleLabel(textAlignment: .left, fontSize: 16)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        containerView.backgroundColor                       = .systemGray4
        containerView.layer.cornerRadius                    = 3.0
        containerView.layer.shadowColor                     = UIColor.gray.cgColor
        containerView.layer.shadowOffset                    = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowRadius                    = 5
        containerView.layer.shadowOpacity                   = 0.3
        containerView.layer.masksToBounds                   = false
        containerView.clipsToBounds                         = false
        
        NSLayoutConstraint.activate([
              containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
              containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
              containerView.heightAnchor.constraint(equalToConstant: 70),
              containerView.widthAnchor.constraint(equalToConstant: 375),
        ])

    }
    
    private func configureImageUsernameHandle() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(twitterhandle)
        
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            twitterhandle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            twitterhandle.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 3),
            twitterhandle.widthAnchor.constraint(equalToConstant: 100),
            twitterhandle.heightAnchor.constraint(equalToConstant: 40),
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
            followerText.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            followerText.widthAnchor.constraint(equalToConstant: 75),
            followerText.heightAnchor.constraint(equalToConstant: 20),
            
            followerCount.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followerCount.leadingAnchor.constraint(equalTo: followerText.trailingAnchor, constant: 5),
            followerCount.widthAnchor.constraint(equalToConstant: 30),
            followerCount.heightAnchor.constraint(equalToConstant: 20),

            followingText.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followingText.leadingAnchor.constraint(equalTo: followerCount.trailingAnchor, constant: 20),
            followingText.widthAnchor.constraint(equalToConstant: 75),
            followingText.heightAnchor.constraint(equalToConstant: 20),

            followingCount.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            followingCount.leadingAnchor.constraint(equalTo: followingText.trailingAnchor, constant: 5),
            followingCount.widthAnchor.constraint(equalToConstant: 30),
            followingCount.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func setFollower(follower: FollowersData) {
        avatarImageView.downloadImage(fromURL: follower.profile_image_url)
        usernameLabel.text = follower.name
        twitterhandle.text = "@\(follower.username)"
        followerCount.text = String(follower.public_metrics.followers_count)
        followingCount.text = String(follower.public_metrics.following_count)
    }
    
    func setFollowing(following: FollowingData) {
        avatarImageView.downloadImage(fromURL: following.profile_image_url)
        usernameLabel.text = following.name
        twitterhandle.text = "@\(following.username)"
        followerCount.text = String(following.public_metrics.followers_count)
        followingCount.text = String(following.public_metrics.following_count)
        
    }
    
    
}
