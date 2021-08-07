//
//  NetworkManager.swift
//  Flock
//
//  Created by Wook Rhyu on 6/9/21.
//

import UIKit

class NetworkManager {
    static let shared                       = NetworkManager()
    var arrayOfFollowers: [FollowersData]   = []
    var arrayOfFollowing: [FollowingData]   = []
    var arrayOfTweets: [TweetsData]         = []
    let cache                               = NSCache<NSString, UIImage>()
    

    func getUserInfo(for username: String, completed: @escaping(Result<User,FError>) -> Void){
        
        let endpoint = "https://api.twitter.com/2/users/by/username/\(username)?user.fields=description,public_metrics,profile_image_url"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidHandle))
            return
        }
        
        var request = URLRequest(url:url)
        request.setValue("Bearer AAAAAAAAAAAAAAAAAAAAAJT5QQEAAAAAp5RfJ7XanIvNvR%2B6bVWuF17RLLk%3DcY69HP1qFQlHLgWliUMbIRAabxtdr6sP1zVuAmnRERm0kLF91D", forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completed(.failure(.networkError))
            }
            
            if let data = data{
                do {
                    let userInfo = try JSONDecoder().decode(User.self, from: data)
                    completed(.success(userInfo))
                } catch {
                    completed(.failure(.networkError))
                }
            }
        }
        task.resume()
    }

    private func getFollowers(for userID: Int, completed: @escaping (Result<Followers,FError>) -> Void){
        
        let endpoint = "https://api.twitter.com/2/users/\(userID)/followers?user.fields=profile_image_url,public_metrics,description&max_results=300"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidHandle))
            return
        }
        
        var request = URLRequest(url:url)
        request.setValue("Bearer AAAAAAAAAAAAAAAAAAAAAJT5QQEAAAAAp5RfJ7XanIvNvR%2B6bVWuF17RLLk%3DcY69HP1qFQlHLgWliUMbIRAabxtdr6sP1zVuAmnRERm0kLF91D", forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completed(.failure(.networkError))
            }
        
            if let data = data{
                do {
                    let followers = try JSONDecoder().decode(Followers.self, from: data)
                    completed(.success(followers))
                } catch {
                    completed(.failure(.networkError))
                }
            }
        }
        task.resume()
    }
    
    private func getFollowing(for userID: Int, completed: @escaping (Result<Following,FError>) -> Void){
        
        let endpoint = "https://api.twitter.com/2/users/\(userID)/following?user.fields=profile_image_url,public_metrics,description&max_results=300"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidHandle))
            return
        }
        
        var request = URLRequest(url:url)
        request.setValue("Bearer AAAAAAAAAAAAAAAAAAAAAJT5QQEAAAAAp5RfJ7XanIvNvR%2B6bVWuF17RLLk%3DcY69HP1qFQlHLgWliUMbIRAabxtdr6sP1zVuAmnRERm0kLF91D", forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completed(.failure(.networkError))
            }
            
            if let data = data{
                do {
                    let following = try JSONDecoder().decode(Following.self, from: data)
                    completed(.success(following))
                } catch {
                    completed(.failure(.networkError))
                }
            }
        }
        
        task.resume()
    }
    
    func followersFromID(username: String, completed: @escaping(Result<[FollowersData], FError>) -> Void){
        getUserInfo(for: username) { result in
            
            switch result {
            case .success(let user):
                let userID = Int(user.data.id)
                self.getFollowers(for: userID!) { result in
                    
                    switch result {
                    case .success(let followers):
                        for follower in followers.data{
                            self.arrayOfFollowers.append(follower)
                        }
                        completed(.success(self.arrayOfFollowers))
                    case .failure(_):
                        completed(.failure(.networkError))
                    }
                }
            case .failure(_):
                completed(.failure(.networkError))
            }
        }
    }
    
    func followingFromID(username: String, completed: @escaping (Result<[FollowingData], FError>) -> Void){
        getUserInfo(for: username) { result in
            
            switch result {
            case .success(let user):
                let userID = Int(user.data.id)
                self.getFollowing(for: userID!) { result in
                    
                    switch result {
                    case .success(let followings):
                        for follow in followings.data{
                            self.arrayOfFollowing.append(follow)
                        }
                        completed(.success(self.arrayOfFollowing))
                    case .failure(_):
                        completed(.failure(.networkError))
                    }
                }
            case .failure(_):
                completed(.failure(.networkError))
            }
            
        }
    }
    
    func getTweets(of id: String, completed: @escaping (Result<Tweets, FError>)-> Void){
        
        let endpoint = "https://api.twitter.com/2/users/\(id)/tweets?max_results=30"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidHandle))
            return
        }
        
        var request = URLRequest(url:url)
        request.setValue("Bearer AAAAAAAAAAAAAAAAAAAAAJT5QQEAAAAAp5RfJ7XanIvNvR%2B6bVWuF17RLLk%3DcY69HP1qFQlHLgWliUMbIRAabxtdr6sP1zVuAmnRERm0kLF91D", forHTTPHeaderField:"Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completed(.failure(.networkError))
            }
            
            if let data = data{
                do {
                    let tweets = try JSONDecoder().decode(Tweets.self, from: data)
                    completed(.success(tweets))
                } catch {
                    completed(.failure(.networkError))
                }
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void){
        
        let cacheKey = NSString(string: urlString)//***
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        
        let newURL = "\(urlString.dropLast(11)).jpg"
        guard let url = URL(string: newURL) else {
            completed(nil)
            return
        }//this is to get a a better quality picture
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self, //maybe watch video here again
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey:cacheKey)
            completed(image)
                  
        }
        task.resume()
    }

}

