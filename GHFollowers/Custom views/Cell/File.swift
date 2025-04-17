//
//  File.swift
//  GHFollowers
//
//  Created by Begench on 17.04.2025.
//


static let identifier = "CHFollowerCell"
    let image = CHImageView(frame: .zero)
    let nameLabel = CHTitleLabel(textAligment: .center, textSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        nameLabel.text = follower.login
        image.downloadImage(from: follower.avatarUrl)
    }
    
    
    
    private func configure() {
        addSubview(nameLabel)
        addSubview(image)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }