//
//  FAlertVC.swift
//  Flock
//
//  Created by Wook Rhyu on 6/8/21.
//

import UIKit

class FAlertVC: UIViewController {
    
    let containerView                   = FAlertContainerView()
    let titleLabel                      = FTitleLabel(textAlignment: .center, fontSize: 20, weight: .bold)
    let messageLabel                    = FBodyLabel(textAlignment: .center)
    let searchButton                    = FButton(backgroundColor: Colors.lightGreyBlue, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var errorType: FError
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String, errorType: FError) {
        self.alertTitle                 = title
        self.message                    = message
        self.buttonTitle                = buttonTitle
        self.errorType                  = errorType
        super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor            = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureSearchButton()
        configureMessageLabel()
        
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        
        if errorType == .networkError {
            searchButton.addTarget(self, action: #selector(backToMainSearch), for: .touchUpInside)
        } else {
            searchButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        }
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            searchButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            searchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    func configureMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: searchButton.topAnchor, constant: -12)
        ])
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func backToMainSearch() {
        dismiss(animated: true)
    }
    


}
