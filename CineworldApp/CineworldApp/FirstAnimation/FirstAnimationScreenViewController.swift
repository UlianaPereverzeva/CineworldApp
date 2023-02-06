//
//  FirstAnimationScreenViewController.swift
//  CineworldApp
//
//  Created by ульяна on 5.02.23.
//

import UIKit

class FirstAnimationScreenViewController: UIViewController {
    
    let logoImage = UIImageView()
    let purpleBackground  = UIImageView()
    let blackCircle  = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpImage()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCircleAnimating()
    }
    
    func setUpImage() {
        
        self.purpleBackground.translatesAutoresizingMaskIntoConstraints = false
        let backgroundImageView = UIImage(named: "circle")
        self.purpleBackground.contentMode = .scaleAspectFit
        self.purpleBackground.image = backgroundImageView
        self.view.addSubview(self.purpleBackground)
        
        NSLayoutConstraint.activate([
            self.purpleBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.purpleBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.purpleBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.purpleBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            
        ])
        
        self.blackCircle.translatesAutoresizingMaskIntoConstraints = false
        let circleImageView = UIImage(named: "blackCircle")
        self.blackCircle.contentMode = .scaleAspectFit
        self.blackCircle.image = circleImageView
        self.view.addSubview(self.blackCircle)
        
        NSLayoutConstraint.activate([
            self.blackCircle.topAnchor.constraint(equalTo: purpleBackground.topAnchor, constant: 0),
            self.blackCircle.leadingAnchor.constraint(equalTo: purpleBackground.leadingAnchor, constant: 0),
            self.blackCircle.trailingAnchor.constraint(equalTo: purpleBackground.trailingAnchor, constant: 321),
            self.blackCircle.bottomAnchor.constraint(equalTo: purpleBackground.bottomAnchor, constant: -139)
            
        ])
        
        self.logoImage.translatesAutoresizingMaskIntoConstraints = false
        let LogoImageView = UIImage(named: "LogoForAnimation")
        self.logoImage.contentMode = .scaleAspectFit
        self.logoImage.image = LogoImageView
        self.view.addSubview(self.logoImage)
        
        NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: purpleBackground.topAnchor, constant: 705),
            self.logoImage.leadingAnchor.constraint(equalTo: purpleBackground.leadingAnchor, constant: 26),
            self.logoImage.trailingAnchor.constraint(equalTo: purpleBackground.trailingAnchor, constant: -142),
            self.logoImage.bottomAnchor.constraint(equalTo: purpleBackground.bottomAnchor, constant: -17)
            
        ])
    }
    
    func startCircleAnimating() {
        UIView.animate(withDuration: 4, delay: 0) {
            self.blackCircle.frame.origin.x += 146
        } completion: { _ in
            DispatchQueue.main.async {
                let secondViewController = MainPageViewController()
                self.show(secondViewController, sender: nil)
            }
        }
    }
}
