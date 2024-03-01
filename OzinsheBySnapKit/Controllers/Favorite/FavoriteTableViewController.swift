//
//  FavoriteTableViewController.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 28.02.2024.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class FavoriteTableViewController: UITableViewController {
    
    var favorites: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        downloadFavorites()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "FAVORITE".localized()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        cell.setData(movie: favorites[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieinfoVC = DetailViewController()
        
        movieinfoVC.movie  = favorites[indexPath.row]
        navigationController?.pushViewController(movieinfoVC, animated: true)
    }
}

extension FavoriteTableViewController {
    func downloadFavorites(){
        
        self.favorites.removeAll()
        
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200{
                
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array{
                    for item in array{
                        let movie = Movie(json: item)
                        self.favorites.append(movie)
                    }
                    self.tableView.reloadData()
                }else{
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            }
        }
    }
        func setupView() {
            view.backgroundColor = UIColor(named: "White-111827(view, font etc)")
            navigationItem.title = "FAVORITE".localized()
            
        }
      
    }

