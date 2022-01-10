//
//  MainSearchScreenVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/2/21.
//

import UIKit

class MainSearchScreenVC: UIViewController {
    
    let logoImageView = UIImageView()
    let textContainer = UIView()
    let logoBird = UIImageView()
    let twitterHandleTextField = FTextField()
    let welcomeText = FTitleLabel(textAlignment: .left, fontSize: 50, weight: .bold)
    let welcomeDescription = FBodyLabel(textAlignment: .left)
    let searchButton = FButton(backgroundColor: Colors.lightGreyBlue, title: "Search")
    var isTextEntered: Bool { return twitterHandleTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainScreen()
        configureWelcomeText()
        configureTwitterHandleTextField()
        configureSearchButton()
        dissmissKeyboard()
    }
    
    private func configureWelcomeText(){
        view.addSubview(welcomeText)
        view.addSubview(welcomeDescription)
        view.addSubview(logoBird)
        
        welcomeText.text = "Hello!"
        
        logoBird.image = Images.logoBird
        logoBird.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeDescription.text = "Enter a Twitter handle to see their followers and following!"
        welcomeDescription.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            welcomeText.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            welcomeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeText.heightAnchor.constraint(equalToConstant: 50),
            welcomeText.widthAnchor.constraint(equalToConstant: 140),
            
            logoBird.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            logoBird.leadingAnchor.constraint(equalTo: welcomeText.trailingAnchor, constant: 3),
            logoBird.heightAnchor.constraint(equalToConstant: 20),
            logoBird.widthAnchor.constraint(equalToConstant: 25),
            
            welcomeDescription.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 10),
            welcomeDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeDescription.heightAnchor.constraint(equalToConstant: 45),
            welcomeDescription.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    func setupMainScreen(){
        twitterHandleTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.background
    }
    
    func dissmissKeyboard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureTwitterHandleTextField() {
        view.addSubview(textContainer)
        
        textContainer.backgroundColor = .systemGray6
        textContainer.alpha = 0.7
        textContainer.layer.cornerRadius = 20
        textContainer.dropShadow()
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        textContainer.addSubview(twitterHandleTextField)
        
        twitterHandleTextField.delegate = self
        twitterHandleTextField.backgroundColor = .none
        
        NSLayoutConstraint.activate([
            
            textContainer.topAnchor.constraint(equalTo: welcomeDescription.bottomAnchor, constant: 20),
            textContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            textContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            textContainer.heightAnchor.constraint(equalToConstant: 50),
            
            twitterHandleTextField.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 0),
            twitterHandleTextField.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: 20),
            twitterHandleTextField.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: 0),
            twitterHandleTextField.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: 0),
            
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowingAndFollowerTabBarContoller), for: .touchUpInside)
        searchButton.dropShadow()
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: 350),
            searchButton.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: 2),
            searchButton.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor, constant: -2),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushFollowingAndFollowerTabBarContoller() {
        guard !isTextEntered else {
            presentFAlertOnMainThread(title: "Hey!", message: "Seems like you have not entered in anything, Please type in a valid twitter handle", buttonTitle: "Ok", errorType: FError.invalidHandle)
            return
        }
        twitterHandleTextField.resignFirstResponder()
        
        let followingAndFollowerTabBarContoller = FollowingAndFollowerTabBarController()
        let followingVC = FollowingVC(for: twitterHandleTextField.text!)
        let followerVC = FollowerVC(for: twitterHandleTextField.text!)
        let userVC = UserInfoVC(FollowersData: nil, FollowingData: nil, for: twitterHandleTextField.text!)
        followingAndFollowerTabBarContoller.setViewControllers([followerVC, followingVC, userVC], animated: false)
        navigationController?.pushViewController(followingAndFollowerTabBarContoller, animated: true)
    }

}

extension MainSearchScreenVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowingAndFollowerTabBarContoller()
        return true
    }
}
