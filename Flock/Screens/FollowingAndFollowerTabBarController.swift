//
//  FollowingAndFollowerTabBarController.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowingAndFollowerTabBarController: UITabBarController {
    
    init() {
            
            super.init(nibName: nil, bundle: nil)
            object_setClass(self.tabBar, CustomTabBar.self)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.barTintColor                 = .systemBackground
        tabBar.alpha                        = 0.98
//        tabBar.tintColor                    = .systemRed
//        tabBar.unselectedItemTintColor      = .systemGreen
        tabBar.layer.cornerRadius           = 5
        tabBar.layer.maskedCorners          = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds          = true
        tabBar.itemPositioning              = .fill
    }
    
    class CustomTabBar: UITabBar {
            override func sizeThatFits(_ size: CGSize) -> CGSize {
                var sizeThatFits = super.sizeThatFits(size)
                sizeThatFits.height = 70
                return sizeThatFits
            }
        }
   
}



