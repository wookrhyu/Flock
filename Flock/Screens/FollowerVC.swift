//
//  FollowerVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowerVC: FDataLoadingVC {
    
    // enum and use switch
    
    let tableView                               = UITableView()
    var followers: [FollowersData]              = []
    var username: String!
    init(for username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
        title                                   = "Followers"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
        configureTableView()
        getFollowers(username: username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func configureViewContoller() {
        
        view.backgroundColor                    = .systemBackground
    }
    
    private func configureNavigationBar(){
        
        let navbar                                  = navigationController
        
        navbar?.navigationBar.topItem?.title        = username
        navbar?.navigationBar.prefersLargeTitles    = true
        navbar?.navigationBar.barTintColor          = .systemBackground
        
        navbar?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)

        tableView.frame                         = view.bounds
        tableView.rowHeight                     = 75
        tableView.delegate                      = self
        tableView.dataSource                    = self
        tableView.separatorStyle                = .none
        tableView.backgroundColor               = .systemBackground
        
        tableView.register(FollowerAndFollowingCell.self, forCellReuseIdentifier: FollowerAndFollowingCell.reuseID)
    }
    
    private func getFollowers(username: String) {
       
        showLoadingView()
        NetworkManager.shared.followersFromID(username: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
            }
        }
    }
    
    private func updateUI(with followers: [FollowersData]) {
        
        if followers.isEmpty{
            print("empty")
        } else {
            self.followers = followers
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)//try to figure out why this happens
            }
        }
    }
}

extension FollowerVC: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell     = tableView.dequeueReusableCell(withIdentifier: FollowerAndFollowingCell.reuseID) as! FollowerAndFollowingCell
        let follower = followers[indexPath.row]
        cell.setFollower(follower: follower)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destVC = FollowersUserInfoVC(FollowersData: followers[indexPath.row])
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}
