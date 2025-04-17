//
//  UIVIew + EXT.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//


import UIKit


extension UIView {
    func addSubViews(_ view: UIView...) {
        view.forEach {
            addSubview($0)
        }
    }
}

