//
//  CatListViewController.swift
//  CatsApp
//
//  Created by Resat Pekgozlu on 16/02/2024.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

class CatListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var catBreeds: [CatBreed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CatCell.nib(), forCellReuseIdentifier: CatCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
                
        fetchCatBreeds()
    }
    
    @objc func refresh(_ sender: Any) {
        fetchCatBreeds()
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
    func fetchCatBreeds() {
        
        if let apiKey = KeychainHelper.loadAPIKey() {
            // Use the apiKey for API requests
            let apiUrl = "https://api.thecatapi.com/v1/breeds/?page=1&limit=15"
            
            let headers: HTTPHeaders = ["x-api-key": apiKey]
            
            AF.request(apiUrl, headers: headers).responseDecodable(of: [CatBreed].self) { response in
                switch response.result {
                case .success(let breeds):
                    self.catBreeds = breeds
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching cat breeds: \(error.localizedDescription)")
                }
            }
        } else {
            // Handle case where apiKey is not found
            print("API Key not found!")
        }
    }
}

extension CatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCell.identifier, for: indexPath) as! CatCell
        let breed = catBreeds[indexPath.row]
        
        cell.titleLabel.text = breed.name
        cell.descriptionLabel.text = breed.description
        cell.catImageView.sd_setImage(with: URL(string: "https://cdn2.thecatapi.com/images/\(breed.imageId).jpg"), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CatCell.height
    }
}
