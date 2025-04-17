//
//  CHUserInfoView.swift
//  GHFollowers
//
//  Created by Begench on 15.04.2025.
//

import UIKit

class CHUserInfoView: UIView {

    let userInfo: User
    
    init(user: User) {
        userInfo = user
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
       
    }

}
