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

    var filterdata: [String]!
    var carData = ["Audi", "BMW", "Mers"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterdata = carData
        setUpSearchBar()

        setupTableView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        tableView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
    }
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
        filterdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.contentView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        let film = filterdata[indexPath.row]
        cell.configure(film: film) //filterdata[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchPageViewController: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterdata = searchText.isEmpty ? carData : carData.filter { (item: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
//
//        tableView.reloadData()
        filterdata = []
        if searchText == "" {
            filterdata = carData
        }
        for word in carData {
            if word.uppercased().contains(searchText.uppercased()) {
                filterdata.append(word)
            }
        }
        self.tableView.reloadData()
    }
}
//extension UISearchBar {
//    func setTextFieldColor(_ color: UIColor) {
//        for subView in self.subviews {
//            for subSubView in subView.subviews {
//                let view = subSubView as? UITextInputTraits
//                if view != nil {
//                    let textField = view as? UITextField
//                    textField?.backgroundColor = color
//                    break
//                }
//            }
//        }
//    }
//}
