//
//  UserInfoHeaderVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/24/21.
//

import UIKit

struct followersOrFollowingOrUserData {
    var id: String!
    var profile_image_url: String!
    var name: String!
    var description: String!
    var username: String!
    var followers_count: String!
    var following_count: String!
}

class UserInfoHeaderVC: UIViewController {
    
    let avatarImageView = FAvatarImageView(frame: .zero)
    let usernameLabel = FTitleLabel(textAlignment: .left, fontSize: 30, weight: .bold)
    let twitterhandle = FSecondaryTitleLabel(textAlignment: .left, fontSize: 17)
    let bio = FBodyLabel(textAlignment: .center)
    let followerText = FTitleLabel(textAlignment: .left, fontSize: 18, weight: .semibold)
    let followingText = FTitleLabel(textAlignment: .left, fontSize: 18, weight: .semibold)
    let followerCount = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    let followingCount = FTitleLabel(textAlignment: .left, fontSize: 16, weight: .semibold)
    
    let stackUsernameHandleMetrics = UIStackView()
    let stackMetrics = UIStackView()
    let stackFollowersCount = UIStackView()
    let stackFollowingCount = UIStackView()
    
    var followersData: FollowersData?
    var followingData: FollowingData?
    var userData: User?
    var headerData: followersOrFollowingOrUserData?
        

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        view.layer.cornerRadius = 10
        configureHeaderInfo()
        setElementsToVariables(for: headerData!)
        configureImageAndBio()
        configureStackViews()
    }
     
    init(FollwersData: FollowersData?, FollowingData: FollowingData?, UserData: User?) {
        self.followersData = FollwersData
        self.followingData = FollowingData
        self.userData = UserData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderInfo() {
        if followingData != nil {
            headerData = followersOrFollowingOrUserData.init(
                id: followingData!.id,
                profile_image_url: followingData!.profile_image_url,
                name: followingData!.name,
                description: followingData!.description,
                username: followingData!.username,
                followers_count: String(followingData!.public_metrics.followers_count),
                following_count: String(followingData!.public_metrics.following_count))
        }else if followersData != nil{
            headerData = followersOrFollowingOrUserData.init(
                id: followersData!.id,
                profile_image_url: followersData!.profile_image_url,
                name: followersData!.name,
                description: followersData!.description,
                username: followersData!.username,
                followers_count: String(followersData!.public_metrics.followers_count),
                following_count: String(followersData!.public_metrics.following_count))
        }else{
            headerData = followersOrFollowingOrUserData.init(
                id: userData!.data.id,
                profile_image_url: userData!.data.profile_image_url,
                name: userData!.data.name,
                description: userData!.data.description,
                username: userData!.data.username,
                followers_count: String(userData!.data.public_metrics.followers_count),
                following_count: String(userData!.data.public_metrics.following_count))
        }
    }
    
    private func setElementsToVariables(for data: followersOrFollowingOrUserData) {
        avatarImageView.downloadImage(fromURL: (data.profile_image_url)!)
        usernameLabel.text = data.name
        twitterhandle.text = "@\(data.username ?? "'empty'")" //****
        bio.text = data.description
        bio.numberOfLines = 4
        followerCount.text = data.followers_count
        followingCount.text = data.following_count
        bio.backgroundColor = Colors.background
        bio.textColor = .black
        avatarImageView.dropShadow()
        avatarImageView.layer.cornerRadius = 10
        avatarImageView.layer.masksToBounds = true
        
    }
    
    private func configureImageAndBio() {
        view.addSubview(avatarImageView)
        view.addSubview(bio)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.widthAnchor.constraint(equalToConstant: 95),
            avatarImageView.heightAnchor.constraint(equalToConstant: 95),
        
            bio.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 5),
            bio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bio.widthAnchor.constraint(equalToConstant: 370),
            bio.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func configureStackViews() {
        view.addSubview(stackUsernameHandleMetrics)
        stackUsernameHandleMetrics.addArrangedSubview(usernameLabel)
        stackUsernameHandleMetrics.addArrangedSubview(twitterhandle)
        stackUsernameHandleMetrics.addArrangedSubview(stackMetrics)
        stackUsernameHandleMetrics.axis = .vertical
        stackUsernameHandleMetrics.distribution = .fillProportionally
        stackUsernameHandleMetrics.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackUsernameHandleMetrics.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            stackUsernameHandleMetrics.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            stackUsernameHandleMetrics.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            stackUsernameHandleMetrics.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        followerText.text = "followers"
        followingText.text = "following"
        followerCount.text = headerData!.followers_count
        followingCount.text = headerData!.following_count

        stackMetrics.addArrangedSubview(stackFollowersCount)
        stackMetrics.addArrangedSubview(stackFollowingCount)
        stackMetrics.axis = .horizontal
        stackMetrics.distribution = .fillEqually
        stackMetrics.translatesAutoresizingMaskIntoConstraints = false

        stackFollowersCount.addArrangedSubview(followerText)
        stackFollowersCount.addArrangedSubview(followerCount)
        stackFollowersCount.axis = .vertical
        stackFollowersCount.distribution = .fillEqually
        stackFollowersCount.translatesAutoresizingMaskIntoConstraints = false

        stackFollowingCount.addArrangedSubview(followingText)
        stackFollowingCount.addArrangedSubview(followingCount)
        stackFollowingCount.axis = .vertical
        stackFollowingCount.distribution = .fillEqually
        stackFollowingCount.translatesAutoresizingMaskIntoConstraints = false
        
    }

}
