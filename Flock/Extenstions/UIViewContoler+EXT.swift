//
//  UIViewContoler+EXT.swift
//  Flock
//
//  Created by Wook Rhyu on 6/8/21.
//

import UIKit

extension UIViewController {
    func presentFAlertOnMainThread(title: String, message: String, buttonTitle: String, errorType: FError){
        DispatchQueue.main.async {
            let alertVC = FAlertVC(title: title, message: message, buttonTitle: buttonTitle, errorType: errorType)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func clearData(){
        
    }
}
