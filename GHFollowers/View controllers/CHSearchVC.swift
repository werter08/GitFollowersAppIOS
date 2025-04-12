//
//  CHSearchVC.swift
//  GHFollowers
//
//  Created by Begench on 11.04.2025.
//

import UIKit

class CHSearchVC: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gh-logo")!
        return image
    }()
    
    let searchTextField = CHTextField()
    let searchButton = CHButton(bgColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool {
        return !searchTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        searchTextField.delegate = self
        searchButton.addTarget(self, action: #selector(pushToFollowersList), for: .touchUpInside)
        
        view.addSubview(logoImageView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        setConstrains()
        inputRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func inputRecognizer() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func pushToFollowersList() {
        guard isUserNameEntered else {
            presentCHAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know the name to check ", buttonTitle: "OK")
            return
        }
        let followersList = CHFollowerListVC()
        followersList.username = searchTextField.text
        followersList.title = searchTextField.text
        navigationController?.pushViewController(followersList, animated: true)
    }
    
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }

    
}

extension CHSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersList()
        return true
    }
}
