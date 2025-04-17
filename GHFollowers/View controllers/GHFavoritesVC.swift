//
//  GHFavoritesVC.swift
//  GHFollowers
//
//  Created by Begench on 11.04.2025.
//

import UIKit

class GHFavoritesVC: UIViewController {

    

    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavorites()
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(CHFavoriteCell.self, forCellReuseIdentifier: CHFavoriteCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
    }
    
    
    func getFavorites() {
        CHPersictenceManager.retriveFavorites { [weak self] results in
            guard let self else {return}
            switch results {
            case .success(let favorites):
                if favorites.isEmpty {
                    showEmptyScreenView(with: "No favorites\nAdd anyone", in: self.view)
                    return
                } else {
                    DispatchQueue.main.async {
                        self.favorites = favorites
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentCHAlertOnMainThread(title: "Somethong went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    
}

//MARK: - TableView
extension GHFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CHFavoriteCell.identifier) as? CHFavoriteCell else {
            return UITableViewCell()
        }
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let favorite = favorites[indexPath.row]
 
        let info = CHUserInfoVC()
        info.userName = favorite.login
        info.delegate = self
        let navC = UINavigationController(rootViewController: info)
        present(navC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        CHPersictenceManager.updateFavorite(favorite: favorite, updateWith: .remove) { [weak self] error in
            guard let error else { return }
            
            self?.presentCHAlertOnMainThread(title: "Somethong went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
}

extension GHFavoritesVC: CHFollowerListVCdelegate {
    
    func didRequestFollowers(for username: String) {
        let followerVC = CHFollowerListVC()
        followerVC.username = username
        followerVC.title = username
        
        navigationController?.pushViewController(followerVC, animated: true)
    }
     
        
   
}
