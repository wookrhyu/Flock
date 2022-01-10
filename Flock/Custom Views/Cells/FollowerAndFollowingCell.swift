//
//  FollowerAndFollowingCell.swift
//  Flock
//
//  Created by Wook Rhyu on 6/10/21.
//

import UIKit

class FollowerAndFollowingCell: UITableViewCell {
    
    static let reuseID = "FAFcell"
    
    let containerView = UIView()
    let avatarImageView = FAvatarImageView(frame: .zero)
    let usernameLabel = FTitleLabel(textAlignment: .left, fontSize: 25, weight: .bold)
    let followerText = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followingText = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followerCount = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followingCount = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    
    let textAndCountA = UIStackView()
    let textAndCountB = UIStackView()
    let StackAB = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.lightGreyBlue
        configureContainerView()
        configureTextColors()
        configureImageUsernameHandle()
        configureText()
        configureStackViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView() {

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Colors.background
        containerView.layer.cornerRadius = 10
        contentView.dropShadow()
        
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
    
    private func configureTextColors() {
        usernameLabel.textColor = Colors.darkGreyBlue
        followerText.textColor = Colors.greyBlue
        followerCount.textColor = Colors.greyBlue
        followingText.textColor = Colors.greyBlue
        followingCount.textColor = Colors.greyBlue
    }
    
    private func configureStackViews() {
        textAndCountA.addArrangedSubview(followerText)
        textAndCountA.addArrangedSubview(followerCount)
        textAndCountA.axis = .horizontal
        textAndCountA.distribution = .fillProportionally
        
        textAndCountB.addArrangedSubview(followingText)
        textAndCountB.addArrangedSubview(followingCount)
        textAndCountB.axis = .horizontal
        textAndCountB.distribution = .fillProportionally
        
        StackAB.addArrangedSubview(textAndCountA)
        StackAB.addArrangedSubview(textAndCountB)
        StackAB.axis = .horizontal
        StackAB.distribution = .fillEqually
        StackAB.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(StackAB)
        
        NSLayoutConstraint.activate([
            StackAB.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            StackAB.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: 2),
            StackAB.widthAnchor.constraint(equalToConstant: 300),
            StackAB.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    private func configureText() {
        
        let textColor:UIColor = UIColor.black
        
        followerText.text = "followers"
        followingText.text = "following"
        followerCount.textColor = textColor
        followingCount.textColor = textColor
        followerText.textColor = textColor
        followingText.textColor = textColor
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
