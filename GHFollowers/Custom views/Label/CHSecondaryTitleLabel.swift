//
//  CHSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Begench on 15.04.2025.
//

import UIKit

class CHSecondaryTitleLabel: UILabel {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
  
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = .systemFont(ofSize: fontSize, weight: .medium)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        font = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
