//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Begench on 12.04.2025.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    public let perPageResults = 100
    let cashe = NSCache<NSString, UIImage>()
    private init() {}
    
    func getFollowers(for username: String, page: Int, complated: @escaping(Result<[Follower], CHError>) -> Void ){
        let endpoint = baseUrl + "\(username)/followers?per_page=\(perPageResults)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            complated(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                complated(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                complated(.failure(.unableRequest))
                return
            }
            
            guard let data = data else {
                complated(.failure(.invalidData))
                return
            }
            
            do {
                //making decoder to decode from json to that king of object that we wont ([follower])
                let decoder = JSONDecoder()
                
                //we wrote a key (name of var) like comble case but in api that was with snake case. we must convert
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                complated(.success(followers))
            } catch {
                complated(.failure(.invalidData))
               
            }
            
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, complated: @escaping(Result<User, CHError>) -> Void ){
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            complated(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                complated(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                complated(.failure(.unableRequest))
                return
            }
            
            guard let data = data else {
                complated(.failure(.invalidData))
                return
            }
            
            do {
                //making decoder to decode from json to that king of object that we wont ([follower])
                let decoder = JSONDecoder()
                
                //we wrote a key (name of var) like comble case but in api that was with snake case. we must convert
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(User.self, from: data)
                complated(.success(user))
            } catch {
                complated(.failure(.invalidData))
               
            }
            
        }
        task.resume()
    }
    
}
