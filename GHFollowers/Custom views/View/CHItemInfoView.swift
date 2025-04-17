//
//  CHItemInfoView.swift
//  GHFollowers
//
//  Created by Begench on 15.04.2025.
//

import UIKit

enum itemInfoType {
    case repos, gists, followers, following
}


class CHItemInfoView: UIView {
    let iconView = UIImageView()
    let titleLabel = CHTitleLabel(textAligment: .left, textSize: 14)
    let countLabel = CHTitleLabel(textAligment: .center, textSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        addSubViews(iconView, titleLabel, countLabel)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFill
        iconView.tintColor = .label
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func set(itemInfoType: itemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            iconView.image = UIImage(systemName: CHSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            iconView.image = UIImage(systemName: CHSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            iconView.image = UIImage(systemName: CHSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            iconView.image = UIImage(systemName: CHSymbols.following)
            titleLabel.text = "Following"
        }
        countLabel.text = String(count)
    }
}
