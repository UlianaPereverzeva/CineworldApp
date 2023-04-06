//
//  MyFilmsViewController.swift
//  CineworldApp
//
//  Created by ульяна on 6.02.23.
//

import UIKit
import RealmSwift


class FavoritesFilmsViewController: UIViewController {
    var realmService = RealmService()
    var favoriteslist = [Favoriteslist]()
    //var token: NotificationToken?
    var favoritesLabel = UILabel()
    var arrayOfFavorites = [FilmModel]()
    var filmID = [Int]()
    var arrayOfNames = [String]()
    var arrayOfPosters = [UIImageView]()
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupTableView()

        //realmService.localRealm.deleteAll()
        updateData()
//        token = realmService.localRealm.observe({ [weak self] _, realm in
//            self?.updateData()
//        })

        tableView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        
    }
    
    func updateData() {
        favoriteslist = realmService.localRealm.objects(Favoriteslist.self).map({ $0 })
        tableView.reloadData()
    }
    
    
    
    private func setUpUI() {
        favoritesLabel.text = "Избранное"
        favoritesLabel.numberOfLines = 0
        favoritesLabel.textColor = .white
        favoritesLabel.textAlignment = .center
        favoritesLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        self.view.addSubview(favoritesLabel)
        
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favoritesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        favoritesLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -120).isActive = true
        favoritesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120).isActive = true
        
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favoritesCell")
        self.tableView = tableView
   }
}
extension FavoritesFilmsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        let favoriteslist = favoriteslist[indexPath.row]
   
        //let id = filmID[indexPath.row]
        let data = favoriteslist.poster
        let poster = UIImage(data: data as Data)
        cell.configure(film: favoriteslist.name, poster: poster!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let favorites = favoriteslist[indexPath.row]
            self.favoriteslist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            try? realmService.localRealm.write {
                 realmService.localRealm.delete(favorites)
            }
        }
    }
}
