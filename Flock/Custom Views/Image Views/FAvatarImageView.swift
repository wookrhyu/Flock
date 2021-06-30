//
//  FAvatarImageView.swift
//  Flock
//
//  Created by Wook Rhyu on 6/10/21.
//

import UIKit

class FAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 3
        clipsToBounds       = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode         = .scaleAspectFill
    }
    
    func downloadImage(fromURL url: String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {self.image = image}
        }
    }
    
    
}
