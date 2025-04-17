//
//  CHFavoriteCell.swift
//  GHFollowers
//
//  Created by Begench on 17.04.2025.
//

import UIKit

class CHFavoriteCell: UITableViewCell {

    static let identifier = "CHFavoriteCell"
    let image = CHImageView(frame: .zero)
    let nameLabel = CHTitleLabel(textAligment: .left, textSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        nameLabel.text = favorite.login
        image.downloadImage(from: favorite.avatarUrl)
    }
    
    
    
    private func configure() {
        addSubview(nameLabel)
        addSubview(image)
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
     
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 2*padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 28)
            
            
        ])
        
    }

}
