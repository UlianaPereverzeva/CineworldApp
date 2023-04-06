//
//  SearchPageViewController.swift
//  CineworldApp
//
//  Created by ульяна on 6.02.23.
//

import UIKit

class SearchPageViewController: UIViewController {

    var tableView: UITableView!
    var searchBar: UISearchBar = UISearchBar()
    var filmID = [658, 6379, 729, 740, 651, 652, 656, 659, 661, 664, 666, 688, 689, 447301]

    var arrayOfFilms = [Films]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        setupTableView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        tableView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
    }
    
//    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        guard let text = searchController.searchBar.text,
//              let keyword = searchBar.text else { return }
//        if text.count > 2 {
//            NetworkService.fetchFilmsBySearch(keyword: keyword) { searchModel, error in
//                guard let searchModel = searchModel?.films else { return }
//                self.arrayOfFilms = searchModel
//                self.tableView.reloadData()
//
//            }
//        }
//    }
//
    private func setUpSearchBar() {
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
            textfield.textColor = .white
        }
        searchBar.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00).cgColor
        searchBar.layer.borderWidth = 3
        searchBar.layer.cornerRadius = 30
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        view.backgroundColor = .systemBackground
        searchBar.barTintColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        searchBar.tintColor = .green
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        //searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView = tableView
       }

}
extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        let film = arrayOfFilms[indexPath.item]
        
        cell.configure(film: film)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FilmViewController()
        let film = arrayOfFilms[indexPath.item]
        vc.filmID = film.filmId
//        guard let urlString = film.posterUrl,
//              let url = URL(string: urlString) else { return }
//        vc.mainImageOfFilm.kf.setImage(with: url)
        //vc.postId = post[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchPageViewController: UISearchBarDelegate {
//
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//                if !searchText.isEmpty {
//                    return arrayOfFilms.filter { $0.contains(searchText) }
//
//                } else {
//                }
        guard let text = searchBar.text else { return }
        if text.count > 2 {
            NetworkService.fetchFilmsBySearch(keyword: text) { searchModel, error in
                guard let searchModel = searchModel?.films else { return }
                self.arrayOfFilms = searchModel
            }
        } else {
         arrayOfFilms.removeAll()
        }
        self.tableView.reloadData()

    }
}

