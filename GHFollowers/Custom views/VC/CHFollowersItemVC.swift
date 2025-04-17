//
//  CHRepoItemVC 2.swift
//  GHFollowers
//
//  Created by Begench on 16.04.2025.
//



class CHFollowersItemVC: CHItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    func configureItem() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        button.set(bgColor: .systemGreen, title: "Get followers")
    }
    
    override func action() {
        delegate.didTapFollowerButton(for: user)
    }
}
