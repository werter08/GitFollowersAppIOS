//
//  CHRepoItemVC.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//


class CHRepoItemVC: CHItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        button.set(bgColor: .systemPurple, title: "Github profile")

    }
    override func action() {
        delegate.didTapRepoButton(for: user)
    }
}
