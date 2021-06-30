//
//  TweetCell.swift
//  Flock
//
//  Created by Wook Rhyu on 6/28/21.
//

import UIKit

class TweetCell: UITableViewCell {
    
    let tweet  = FTitleLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        configureTweetLabel()
    }
    
    private func configureTweetLabel() {
        addSubview(tweet)
        tweet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tweet.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tweet.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            tweet.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            tweet.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTweet(tweetData: TweetsData) {
        tweet.text = tweetData.text
    }
}
