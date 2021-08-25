//
//  FollowingAndFollowerVC.swift
//  Flock
//
//  Created by Wook Rhyu on 8/23/21.
//

import UIKit

enum DataType {
    case Followers
    case Following
}

class FollowingAndFollowerVC: FDataLoadingVC{
    
    let tableView = UITableView()
    var following: [FollowingData] = []
    var follower: [FollowersData] = []
    var username: String!
    var dataType: DataType!
    
    
    init(for username: String, data: DataType) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.dataType = data
        title                                   = "Following"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        dataCall(for: dataType)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewContoller()
        configureNavigationBar()
    }
    
    func dataCall(for dataType: DataType){
        switch dataType{
        case .Followers:
            getFollowers(username: username)
        case .Following:
            getFollowing(username: username)
        }
    }
    
    
    
    private func configureViewContoller() {
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar(){
        
        let navbar = navigationController
        
        navbar?.navigationBar.prefersLargeTitles = true
        navbar?.navigationBar.barTintColor = .systemBackground
        navbar?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame                         = view.bounds
        tableView.rowHeight                     = 75
        tableView.delegate                      = self
        tableView.dataSource                    = self
        tableView.separatorStyle                = .singleLine
        tableView.register(FollowerAndFollowingCell.self, forCellReuseIdentifier: FollowerAndFollowingCell.reuseID)
        tableView.backgroundColor               = .systemBackground
    }
    
    private func getFollowing(username: String){
        showLoadingView()
        
        NetworkManager.shared.followingFromID(username: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let following):
                self.updateUI(with: following, for: DataType.Following)
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
                return
            }
        }
    }
    
    private func getFollowers(username: String) {
       
        showLoadingView()
        NetworkManager.shared.followersFromID(username: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers, for: DataType.Follower)
                
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
            }
        }
    }
    
    private func updateUI(with following: [FollowingData], for dataType: DataType){
        if following.isEmpty{
            print("empty")
        } else {
            switch dataType{
            case .Following:
                self.following = following
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)//try to figure out why this happens
                }
            case .Followers:
                self.followers = followers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)//try to figure out why this happens
                }
            }
        }
    }
}

extension FollowingAndFollowerVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: FollowerAndFollowingCell.reuseID) as! FollowerAndFollowingCell
        let following = following[indexPath.row]
        cell.setFollowing(following: following)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = FollowingUserInfoVC(FollowingData: following[indexPath.row])
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }

}
