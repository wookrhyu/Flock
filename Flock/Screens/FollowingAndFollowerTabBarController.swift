//
//  FollowingAndFollowerTabBarController.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowingAndFollowerTabBarController: UITabBarController {
    
    var username: String!
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewControllers                                 = [createFollowerNC(), createFollowingNC()]
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigaionBar()
        configureTabBar()
    }
    

    private func createFollowingNC() -> UINavigationController {
        
        let followingNC                                 = FollowingVC(for: username)
        followingNC.title                               = "following"
        
        return UINavigationController(rootViewController: followingNC)
    }
    
    private func createFollowerNC() -> UINavigationController {
        
        let followerNC                                  = FollowerVC(for: username)
        followerNC.title                                = "followers"
        
        return UINavigationController(rootViewController: followerNC)
    }
    
//    private func creatFollowerNC() -> UINavigationController {
//        let userNC                                      = UserInfoVC(
//    }
    
    private func configureTabBar() {
        tabBar.barTintColor                 = .systemGray
//        tabBar.tintColor                    = .systemRed
//        tabBar.unselectedItemTintColor      = .systemGreen
        tabBar.layer.cornerRadius           = 5
        tabBar.layer.maskedCorners          = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds          = true
        tabBar.itemPositioning              = .fill
    }
    
    private func configureNavigaionBar() {
        
        let navbar                                  = navigationController
        navbar?.setNavigationBarHidden(false, animated: true)
        navbar?.navigationBar.barTintColor = .systemFill
    }
   
}


