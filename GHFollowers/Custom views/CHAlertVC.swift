//
//  CHAlertVC.swift
//  GHFollowers
//
//  Created by Begench on 12.04.2025.
//

import UIKit

class CHAlertVC: UIViewController {
    
    let alertView       = UIView()
    let titleLabel      = CHTitleLabel(textAligment: .center, textSize: 20)
    let bodyLabel       = CHBodyLabel(textAligment: .center)
    let actionButton    = CHButton(bgColor: .systemRed, title: "OK")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    var padding: CGFloat = 20
    
    init (alertTitle: String, message: String, buttonTitle: String) {
        self.alertTitle     = alertTitle
        self.message        = message
        self.buttonTitle    = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureView()
    }
    
    private func configureView() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.layer.cornerRadius = 16
        alertView.layer.borderWidth = 2
        alertView.layer.borderColor = UIColor.white.cgColor
        alertView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            alertView.widthAnchor.constraint(equalToConstant: 280),
            alertView.heightAnchor.constraint(equalToConstant: 200),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        configureViewSubs()
    }
    private func configureViewSubs() {
        alertView.addSubview(titleLabel)
        alertView.addSubview(bodyLabel)
        alertView.addSubview(actionButton)

        titleLabel.text         = alertTitle ?? "Something went wrong"
        
        bodyLabel.text          = message ?? "Unable to complate request"
        bodyLabel.numberOfLines = 4
        
        actionButton.setTitle(buttonTitle ?? "OK", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),

            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),
  
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),

        ])
        
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}
