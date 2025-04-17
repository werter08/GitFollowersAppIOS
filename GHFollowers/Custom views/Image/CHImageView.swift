//
//  CHImageView.swift
//  GHFollowers
//
//  Created by Begench on 12.04.2025.
//

import UIKit

class CHImageView: UIImageView {

    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        if let image = NetworkManager.shared.cashe.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data, let image = UIImage(data: data) else { return }
            
            NetworkManager.shared.cashe.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
