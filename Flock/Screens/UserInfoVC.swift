//
//  UserInfoVC.swift
//  Flock
//
//  Created by Wook Rhyu on 8/25/21.
//

import UIKit


class UserInfoVC: FDataLoadingVC {
    
    let headerView                      = UIView()
    let tweetTable                      = UITableView()
    var arrayOfTweets:[TweetsData]      = []

    var followersData: FollowersData?
    var followingData: FollowingData?
    var userData: User?
    var username: String?
    
    let padding: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutBaseViews()
        configureVCFunction()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    init(FollowersData: FollowersData?, FollowingData: FollowingData?, for username: String?) {
        self.followersData = FollowersData
        self.followingData = FollowingData
        self.username = username
        super.init(nibName: nil, bundle: nil)
        title = "\(username ?? "default value")"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureVCFunction() {
        if followersData != nil {
            self.add(
                childVC: UserInfoHeaderVC(
                    FollwersData: followersData,
                    FollowingData: nil,
                    UserData: nil),
                to: self.headerView)
            
            getTweets(id: followersData!.id)
            
        } else if followingData != nil{
            self.add(
                childVC: UserInfoHeaderVC(
                    FollwersData: nil,
                    FollowingData: followingData,
                    UserData: nil),
                to: self.headerView)
            
            getTweets(id: followingData!.id)
            
        } else {
            getUserInfo(for: username!)
        }
        
    }
    
    private func configureNavigationBar() {
        let navbar                  = navigationController
        navbar?.setNavigationBarHidden(true, animated: false)
    }
    
    private func layoutBaseViews() {
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints        = false
        headerView.backgroundColor      = .systemBackground
        headerView.dropShadow()
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 175)
        ])
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
        tweetTable.backgroundColor      = .systemBackground
        NSLayoutConstraint.activate([
            tweetTable.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            tweetTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            tweetTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tweetTable.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func getUserInfo(for username: String){
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            switch result {
            
            case .success(let user):
                self.userData = user
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
            }
            
            DispatchQueue.main.async {
                self.add(
                    childVC: UserInfoHeaderVC(
                        FollwersData: nil,
                        FollowingData: nil,
                        UserData: self.userData),
                    to: self.headerView)
                
                self.getTweets(id: self.userData!.data.id)
            }
        }
        
    }
    
    private func getTweets(id: String){
        showLoadingView()
        
        NetworkManager.shared.getTweets(of: id) {[weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            
            switch result {
            case .success(let tweets):
                for tweet in tweets.data{
                    self.arrayOfTweets.append(tweet)
                }
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
            }
            DispatchQueue.main.async {
                self.tweetTable.reloadData()
            }
        }
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

