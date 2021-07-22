//
//  FollowingUserInfoVC.swift
//  Flock
//
//  Created by Wook Rhyu on 7/5/21.
//

import UIKit

class FollowingUserInfoVC: FDataLoadingVC {
    
    let headerView                      = UIView()
    let tweetTable                      = UITableView()
    var arrayOfTweets:[TweetsData]      = []

    var FollowingData: FollowingData!
    let padding: CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutBaseViews()
        addChildViews(FollowingData: FollowingData!)
        configureTableView()
        getTweets(id: FollowingData!.id)
    }
    
    init(FollowingData: FollowingData) {
        self.FollowingData = FollowingData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func addChildViews(FollowingData: FollowingData){
        self.add(childVC: UserHeaderViewControllerFollowing(FollowingData: FollowingData), to: self.headerView)
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

extension FollowingUserInfoVC: UITableViewDelegate, UITableViewDataSource{
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

