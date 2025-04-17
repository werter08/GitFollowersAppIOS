//
//  CHItemInfoVC.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//

import UIKit


class CHItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = CHItemInfoView()
    let itemInfoViewTwo = CHItemInfoView()
    let button = CHButton()
    
    var delegate: CHUserInfoVCDelegate!
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureStackView()
        configureAction()
    }
    
    func configureVC() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }

    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    func configureAction() {
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc func action() {}
    
    func layoutUI() {
        view.addSubViews(stackView, button)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

}
