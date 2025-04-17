//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Begench on 13.04.2025.
//

import UIKit

struct UIHelper {
    static func configureCollectionViewThreeColmLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let avialeebleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = avialeebleWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
