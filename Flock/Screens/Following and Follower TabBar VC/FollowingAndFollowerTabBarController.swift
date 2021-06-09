//
//  FollowingAndFollowerTabBarController.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowingAndFollowerTabBarController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewControllers                                 = [createFollowerNC(), createFollowingNC()]
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    private func createFollowingNC() -> UINavigationController {
        
        let followingNC                                 = FollowingVC()
        followingNC.title                               = "following"
        
        return UINavigationController(rootViewController: followingNC)
    }
    
    private func createFollowerNC() -> UINavigationController {
        
        let followerNC                                  = FollowerVC()
        followerNC.title                                = "followers"
        
        return UINavigationController(rootViewController: followerNC)
    }
    
    private func configureTabBar() {
        
        let tabbar                                      = UITabBar.appearance()
        let tabbarItem                                  = UITabBarItem.appearance()
        tabbar.backgroundImage                          = UIImage()
        tabbar.shadowImage                              = UIImage()
        
        let attributes: [NSAttributedString.Key: Any]   = [
            .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
            .foregroundColor: UIColor.blue

        ]
        
        tabbarItem.setTitleTextAttributes(attributes, for: .normal)
    
    }
    
    private func configureNavigaionBar() {
        
        let navbar                                  = navigationController
        navbar?.setNavigationBarHidden(false, animated: true)
    }
    

   
}
