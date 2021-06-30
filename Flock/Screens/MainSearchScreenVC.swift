//
//  MainSearchScreenVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/2/21.
//

import UIKit

class MainSearchScreenVC: UIViewController {
    
    let logoImageView           = UIImageView()
    let lowerBirds              = UIImageView()
    let twitterHandleTextField  = FTextField()
    let searchButton            = FButton(backgroundColor: .systemBlue, title: "Search")
    
    var isTextEntered: Bool { return twitterHandleTextField.text!.isEmpty }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureLowerBirds()
        configureTwitterHandleTextField()
        configureSearchButton()
        dissmissKeyboard()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        twitterHandleTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func dissmissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowingAndFollowerTabBarContoller() {
        
        guard !isTextEntered else {
            
            presentFAlertOnMainThread(title: "Hey!", message: "Seems like you have not entered in anything, Please type in a valid twitter handle", buttonTitle: "Ok", errorType: FError.invalidHandle)
            return
        }
        
        twitterHandleTextField.resignFirstResponder()
        let followingAndFollowerTabBarContoller = FollowingAndFollowerTabBarController(username: twitterHandleTextField.text!)
        self.navigationController?.pushViewController(followingAndFollowerTabBarContoller, animated: true)
    }
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.logo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    
    private func configureTwitterHandleTextField() {
        view.addSubview(twitterHandleTextField)
        twitterHandleTextField.delegate = self
        
        NSLayoutConstraint.activate([
            twitterHandleTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 250),
            twitterHandleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            twitterHandleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            twitterHandleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.addTarget(self, action: #selector(pushFollowingAndFollowerTabBarContoller), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: twitterHandleTextField.bottomAnchor, constant: 5),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureLowerBirds() {
        view.addSubview(lowerBirds)
        lowerBirds.translatesAutoresizingMaskIntoConstraints = false
        lowerBirds.image = Images.birds
        lowerBirds.alpha = 0.5
        
        NSLayoutConstraint.activate([
            lowerBirds.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 70),
            lowerBirds.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.widthAnchor.constraint(equalToConstant: 325)
        ])
    }
    

}

extension MainSearchScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowingAndFollowerTabBarContoller()
        return true
    }
}
