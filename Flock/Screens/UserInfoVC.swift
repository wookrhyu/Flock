//
//  UserInfoVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/23/21.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView                      = UIView()
    let tweetTable                      = UITableView()
    var arrayOfTweets:[TweetsData]      = []
    
    var FollowersData: FollowersData
    let padding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        layoutBackViews()
        addChildViews(FollowersData: FollowersData)
        configureTableView()
        getTweets(id: FollowersData.id)
    }
    
    init(FollowersData: FollowersData) {
        self.FollowersData = FollowersData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutBackViews() {
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints        = false
        headerView.backgroundColor      = .systemPink
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    private func addChildViews(FollowersData: FollowersData){
        self.add(childVC: UserHeaderViewController(FollwersData: FollowersData), to: self.headerView)
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
    }
    
    private func configureTableView() {
        view.addSubview(tweetTable)
        
        tweetTable.translatesAutoresizingMaskIntoConstraints = false
        tweetTable.frame                = view.bounds
        tweetTable.rowHeight            = 90
        tweetTable.delegate             = self
        tweetTable.dataSource           = self
        tweetTable.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        
        NSLayoutConstraint.activate([
            tweetTable.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            tweetTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tweetTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tweetTable.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func getTweets(id: String){
        NetworkManager.shared.getTweets(of: id) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let tweets):
                for tweet in tweets.data{
                    self.arrayOfTweets.append(tweet)
                }
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
            }
        }
        tweetTable.reloadData()
    }
}

extension UserInfoVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = arrayOfTweets[indexPath.row]
        cell.setTweet(tweetData: tweet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTweets.count
    }



}

