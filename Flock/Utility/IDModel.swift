//
//  FollowerIDModel.swift
//  Flock
//
//  Created by Wook Rhyu on 6/10/21.
//

import UIKit

struct User: Codable {
    let data: UserData
}

struct UserData: Codable {
    let description: String
    let username: String
    let profile_image_url: String
    let public_metrics: Metrics
    let id: String
    let name: String
}

struct Followers: Codable {
    let data: [FollowersData]
}

struct FollowersData: Codable {
    let id: String
    let profile_image_url: String
    let name: String
    let description: String
    let username: String
    let public_metrics: Metrics
}

//struct FollowersToken: Codable{
//    let next_token: String
//}

struct Following: Codable {
    let data: [FollowingData]
    //let meta: FollowingToken
}

struct FollowingData: Codable {
    let id: String
    let profile_image_url: String
    let name: String
    let description: String
    let username: String
    let public_metrics: Metrics
}

struct FollowingToken: Codable{
    let next_token: String
}

struct Metrics: Codable{
    let followers_count: Int
    let following_count: Int
}

struct Tweets: Codable{
    let data: [TweetsData]
}

struct TweetsData: Codable{
    let id: String
    let text: String
}
