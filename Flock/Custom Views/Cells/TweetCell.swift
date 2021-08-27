//
//  TweetCell.swift
//  Flock
//
//  Created by Wook Rhyu on 6/28/21.
//

import UIKit

class TweetCell: UITableViewCell {
    
    let tweet  = FBodyLabel(textAlignment: .center)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureTweetLabel()
        backgroundColor = .systemBackground
    }
    
    private func configureTweetLabel() {
        addSubview(tweet)
        tweet.numberOfLines = 3
        tweet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tweet.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            tweet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            tweet.widthAnchor.constraint(equalToConstant: 370),
            tweet.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTweet(tweetData: TweetsData) {
        tweet.text = tweetData.text
    }
}
