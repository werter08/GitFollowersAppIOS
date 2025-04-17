//
//  CHFollowerListVC.swift
//  GHFollowers
//
//  Created by Begench on 12.04.2025.
//

import UIKit

protocol CHFollowerListVCdelegate {
    func didRequestFollowers(for username: String)
}

class CHFollowerListVC: UIViewController {

    enum Section {
        case main
    }
    
    var username: String!
    var page = 1
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var hasMoeFollowers = true
    var isSearchong = false
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        configureViewController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: username, page: page)
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getFollowers(username: String, page: Int) {
        self.page += 1
        setLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self else { return }
            self.dissMissLoadingView()
            switch result {
            case .success(let followers):
                self.hasMoeFollowers = followers.count < NetworkManager.shared.perPageResults ? false : true
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user hasnt got any follower 🥲"
                    DispatchQueue.main.async {
                        self.showEmptyScreenView(with: message, in: self.view)
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentCHAlertOnMainThread(title: "Bad Handle", message: error.rawValue, buttonTitle: "OK")
            }
           
        }
    
    }
    
    //MARK: - Cnfigures
    
    func configureCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.configureCollectionViewThreeColmLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(CHFollowerCell.self, forCellWithReuseIdentifier: CHFollowerCell.identifier)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CHFollowerCell.identifier,
                for: indexPath) as! CHFollowerCell
                
            cell.set(follower: follower)
            return cell
        })
    }
    
    func configureSearchController() {
        let searchContrller = UISearchController()
        searchContrller.searchResultsUpdater = self
        searchContrller.searchBar.delegate = self
        searchContrller.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchContrller
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.datasource.apply(snapShot, animatingDifferences: true)

        }
    }
    
    @objc func addButtonTapped() {
        
        setLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self else { return }
            self.dissMissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                CHPersictenceManager.updateFavorite(favorite: favorite, updateWith: .add) {[weak self] error in
                    guard let self else { return }
                    
                    guard let error else {
                        self.presentCHAlertOnMainThread(title: "Success!", message: "The user successufully was added to favorites 😇", buttonTitle: "OK")
                        return
                    }
                    self.presentCHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.presentCHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
}

extension CHFollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMoeFollowers else { return }
            getFollowers(username: username, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follwer = isSearchong ? filteredFollowers[indexPath.row] : followers[indexPath.row]
 
        let info = CHUserInfoVC()
        info.userName = follwer.login
        info.delegate = self
        let navC = UINavigationController(rootViewController: info)
        present(navC, animated: true)
    }
}

extension CHFollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearchong = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        filteredFollowers = []
        isSearchong = false
    }
    
}

extension CHFollowerListVC : CHFollowerListVCdelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        followers.removeAll()
        filteredFollowers.removeAll()
        page = 1
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
    
    
}
