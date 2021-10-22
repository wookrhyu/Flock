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
        object_setClass(self.tabBar, CustomTabBar.self)//****
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        let tabColor: UIColor = .white
        
        tabBar.barTintColor = Colors.lightGreyBlue
        tabBar.alpha = 0.98
        tabBar.tintColor = tabColor
        tabBar.unselectedItemTintColor = Colors.darkGreyBlue
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        tabBar.itemPositioning = .fill
        tabBar.items?.first?.titlePositionAdjustment = UIOffset(horizontal: 30, vertical: 0)
        tabBar.items?.last?.titlePositionAdjustment = UIOffset(horizontal: -33, vertical: 0)

        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
    
    class CustomTabBar: UITabBar { 
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 80
            return sizeThatFits
        }
    }
}



