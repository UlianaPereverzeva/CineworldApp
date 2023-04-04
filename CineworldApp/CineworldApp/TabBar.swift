//
//  TabBar.swift
//  CineworldApp
//
//  Created by ульяна on 6.02.23.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .black
        
        tabBar.tintColor = UIColor(red: 0.31, green: 0.02, blue: 0.66, alpha: 1.00)
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: MainPageViewController(), title: NSLocalizedString("Главное", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SearchPageViewController(), title: NSLocalizedString("Поиск", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: FavoritesFilmsViewController(), title: NSLocalizedString("Мои фильмы", comment: ""), image: UIImage(systemName: "bookmark")!),
            createNavController(for: MyAccountViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
    
}
