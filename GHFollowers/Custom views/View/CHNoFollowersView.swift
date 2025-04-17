//
//  CHNoFollowersView.swift
//  GHFollowers
//
//  Created by Begench on 13.04.2025.
//

import UIKit

class CHNoFollowersView: UIView {

    var image = UIImageView()
    let messege = CHTitleLabel(textAligment: .center, textSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(messageText: String) {
        super.init(frame: .zero)
        messege.text = messageText
        DispatchQueue.main.async {
            self.configure()
        }

    }
    
    
    private func configure() {
        addSubview(messege)
        addSubview(image)
        
        messege.numberOfLines = 3
        messege.textColor = .secondaryLabel

        image.image = UIImage(named: "empty-state-logo")!
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messege.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messege.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messege.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messege.heightAnchor.constraint(equalToConstant: 200),
//            
            image.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            image.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
        ])
    }

}
