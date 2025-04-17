//
//  CHUserInfoVC.swift
//  GHFollowers
//
//  Created by Begench on 15.04.2025.
//

import UIKit
import SafariServices

protocol CHUserInfoVCDelegate {
    func didTapRepoButton(for user: User)
    func didTapFollowerButton(for user: User)
}


class CHUserInfoVC: UIViewController {
    

    var headerView = UIView()
    var itemViewOne = UIView()
    var itemViewTwo = UIView()
    var views: [UIView] = []
    var userName: String!
    
    let dateLabel =  CHBodyLabel(textAligment: .center)
        
    var delegate: CHFollowerListVCdelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissMissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName, complated: { [weak self] result in
            
            guard let self else {return}
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async {
                    self.configureUIElements(user: user)
                }
 
            case .failure(let failure):
                self.presentCHAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "OK")
            }
        })
    }
    
    func configureUIElements(user: User) {
        self.add(childVC: CHUserInfoHeaderVC(user: user), to: self.headerView)
        
        let repoVC = CHRepoItemVC(user: user)
        repoVC.delegate = self
        self.add(childVC: repoVC, to: self.itemViewOne)
        
        let followersVC = CHFollowersItemVC(user: user)
        followersVC.delegate = self
        self.add(childVC: followersVC, to: self.itemViewTwo)
        
        self.dateLabel.text = "Github s ience "+user.createdAt.convertToDisplayFormat()
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        views = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in views {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    @objc func dissMissVC() {
        dismiss(animated: true)
    }

    func add(childVC: UIViewController, to view: UIView) {
        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = view.bounds
        childVC.didMove(toParent: self)
    }
}


extension CHUserInfoVC: CHUserInfoVCDelegate {
    func didTapRepoButton(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentCHAlertOnMainThread(title: "Invalid url", message: "The url attached to this user is invalid", buttonTitle: "OK")
            return
        }
        let safareVC = SFSafariViewController(url: url)
        safareVC.preferredControlTintColor = .systemGreen
        present(safareVC, animated: true)
    }
    
    func didTapFollowerButton(for user: User) {
        guard user.followers != 0 else {
            presentCHAlertOnMainThread(title: "NO followers", message: "This user has no followers. follow him 🥺", buttonTitle: "OK")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dissMissVC()
    }
}
