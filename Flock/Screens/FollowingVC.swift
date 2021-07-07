//
//  FollowingVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowingVC: FDataLoadingVC {
    
    let tableView                               = UITableView()
    var following: [FollowingData]              = []
    var username: String!
    
    init(for username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title                                   = "Following"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getFollowing(username: username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureViewContoller()
    }
    
    private func configureViewContoller() {
        view.backgroundColor                    = .systemBackground
    }
    
    private func configureNavigationBar(){
        let navbar                  = navigationController
        navbar?.setNavigationBarHidden(false, animated: true)
        navbar?.navigationItem.hidesBackButton = true
        navbar?.navigationBar.topItem?.title = username
        navbar?.navigationBar.prefersLargeTitles = true
//        navbar?.navigationBar.layer.masksToBounds = true
//        navbar?.navigationBar.layer.cornerRadius = 20
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame                         = view.bounds
        tableView.rowHeight                     = 75
        tableView.delegate                      = self
        tableView.dataSource                    = self
        tableView.separatorStyle                = .none
        
        tableView.register(FollowerAndFollowingCell.self, forCellReuseIdentifier: FollowerAndFollowingCell.reuseID)
    }
    
    private func getFollowing(username: String){
        showLoadingView()
        
        NetworkManager.shared.followingFromID(username: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let following):
                self.updateUI(with: following)
            case .failure(let error):
                self.presentFAlertOnMainThread(title: "There was a problem", message: error.rawValue, buttonTitle: "Ok", errorType: .networkError)
                return
            }
        }
    }
    
    private func updateUI(with following: [FollowingData]){
        if following.isEmpty{
            print("empty")
        } else {
            self.following = following
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)//try to figure out why this happens
            }
        }
    }
}


extension FollowingVC: UITableViewDataSource, UITableViewDelegate{
    
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
        let destVC = UserInfoVCFollowing(FollowingData: following[indexPath.row])
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

 

