//
//  UserHeaderViewController.swift
//  Flock
//
//  Created by Wook Rhyu on 6/24/21.
//

import UIKit

class UserHeaderViewController: UIViewController {
    
    let avatarImageView         = FAvatarImageView(frame: .zero)
    let usernameLabel           = FTitleLabel(textAlignment: .left, fontSize: 30)
    let twitterhandle           = FSecondaryTitleLabel(textAlignment: .left, fontSize: 17)
    let bio                     = FBodyLabel(textAlignment: .center)
    let followerText            = FTitleLabel(textAlignment: .left, fontSize: 18)
    let followingText           = FTitleLabel(textAlignment: .left, fontSize: 18)
    let followerCount           = FTitleLabel(textAlignment: .left, fontSize: 16)
    let followingCount          = FTitleLabel(textAlignment: .left, fontSize: 16)
    
    var FollowersData: FollowersData!
        

    override func viewDidLoad() {
        super.viewDidLoad()
        setElementsToVariables(FollowersData: FollowersData)
        configureImageAndUserName()
        configureFollowersAndFollowing()
    }
     
    init(FollwersData: FollowersData) {
        self.FollowersData = FollwersData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setElementsToVariables(FollowersData: FollowersData) {
        
        avatarImageView.downloadImage(fromURL: FollowersData.profile_image_url)
        usernameLabel.text      = FollowersData.name
        twitterhandle.text      = "@\(FollowersData.username)"
        bio.text                = FollowersData.description
        bio.numberOfLines       = 4
        followerCount.text      = String(FollowersData.public_metrics.followers_count)
        followingCount.text     = String(FollowersData.public_metrics.following_count)
        bio.textColor           = .black
        bio.backgroundColor     = .systemTeal
        
    }
    
    private func configureImageAndUserName() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(twitterhandle)
        view.addSubview(bio)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 95),
            avatarImageView.heightAnchor.constraint(equalToConstant: 95),
            
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 33),
            
            twitterhandle.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0),
            twitterhandle.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            twitterhandle.heightAnchor.constraint(equalToConstant: 17),
            
            bio.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bio.widthAnchor.constraint(equalToConstant: 370),
            bio.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func configureFollowersAndFollowing() {
        view.addSubview(followerText)
        view.addSubview(followingText)
        view.addSubview(followerCount)
        view.addSubview(followingCount)
        
        followerText.text       = "followers"
        followingText.text      = "following"
        followerCount.text      = String(FollowersData.public_metrics.followers_count)
        followingCount.text     = String(FollowersData.public_metrics.following_count)
        
        
        
        
        NSLayoutConstraint.activate([
            followerText.topAnchor.constraint(equalTo: twitterhandle.bottomAnchor, constant: 3),
            followerText.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            followerText.heightAnchor.constraint(equalToConstant: 23),
            followerText.widthAnchor.constraint(equalToConstant: 100),
            
            followingText.topAnchor.constraint(equalTo: twitterhandle.bottomAnchor, constant: 5),
            followingText.leadingAnchor.constraint(equalTo: followerText.trailingAnchor, constant: 40),
            followingText.heightAnchor.constraint(equalToConstant: 23),
            followingText.widthAnchor.constraint(equalToConstant: 100),
            
            followerCount.topAnchor.constraint(equalTo: followerText.bottomAnchor, constant: 0),
            followerCount.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            followerCount.heightAnchor.constraint(equalToConstant: 17),
            followerCount.widthAnchor.constraint(equalToConstant: 100),
            
            followingCount.topAnchor.constraint(equalTo: followerText.bottomAnchor, constant: 0),
            followingCount.leadingAnchor.constraint(equalTo: followerCount.trailingAnchor, constant: 40),
            followingCount.heightAnchor.constraint(equalToConstant: 17),
            followingCount.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        
    }
    
    

}