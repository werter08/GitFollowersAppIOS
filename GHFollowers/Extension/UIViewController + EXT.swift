//
//  UIViewController + EXT.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//

import UIKit



fileprivate var containerView: UIView!

extension UIViewController {
    func presentCHAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CHAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func setLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
      
        UIView.animate(withDuration: 0.33) { containerView.alpha = 0.8 }
        
        let activateView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activateView)
        
        activateView.translatesAutoresizingMaskIntoConstraints = false
    
        
        NSLayoutConstraint.activate([
            activateView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activateView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        activateView.startAnimating()
    }
    
    func dissMissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }

    }
    
    func showEmptyScreenView(with message: String, in view: UIView) {
        let emptyStateView = CHNoFollowersView(messageText: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
