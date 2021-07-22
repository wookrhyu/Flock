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
        let tabColor: UIColor               = .black
        
        tabBar.barTintColor                 = .systemBackground
        tabBar.alpha                        = 0.98
        tabBar.tintColor                    = tabColor
        tabBar.unselectedItemTintColor      = tabColor
        tabBar.layer.cornerRadius           = 10
        tabBar.layer.maskedCorners          = [ .layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds          = true
        tabBar.itemPositioning              = .fill
        
        let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)

        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: tabColor, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineWidth: 3.0)
    }
    
    class CustomTabBar: UITabBar {
            override func sizeThatFits(_ size: CGSize) -> CGSize {
                var sizeThatFits = super.sizeThatFits(size)
                sizeThatFits.height = 70
                return sizeThatFits
            }
        }
   
}



