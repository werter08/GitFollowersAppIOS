//
//  CHTitleLabel.swift
//  GHFollowers
//
//  Created by Begench on 15.04.2025.
//

import UIKit


class CHTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
  
    init(textAligment: NSTextAlignment, textSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAligment
        font = .systemFont(ofSize: textSize, weight: .bold)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}

