//
//  FollowerVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/3/21.
//

import UIKit

class FollowerVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor        = .systemPink
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
