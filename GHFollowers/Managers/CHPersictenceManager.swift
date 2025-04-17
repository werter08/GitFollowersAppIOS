//
//  CHPersictenceManager.swift
//  GHFollowers
//
//  Created by Begench on 17.04.2025.
//

import Foundation

enum CHPersictenceActionType {
    case add, remove
}

enum CHPersictenceManager {
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let favorites = "Favorites"
    }
    
    static func updateFavorite(favorite: Follower, updateWith: CHPersictenceActionType, completed: @escaping(CHError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                
                switch updateWith {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed(.allreadyInFavorites)
                        return
                    }
                    
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll {
                        $0.login == favorite.login
                    }
                }
                
                completed(save(favorites: retrivedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retriveFavorites(completed: @escaping (Result<[Follower], CHError>) -> Void){
        guard let favoritesData = defaults.object(forKey: keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.invalidFavorites))
        }
    }
    
    static func save(favorites: [Follower]) -> CHError? {

        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: keys.favorites)
            return nil
        }
        catch {
            return .invalidSavingFavorites
        }
    }
    
    
}
