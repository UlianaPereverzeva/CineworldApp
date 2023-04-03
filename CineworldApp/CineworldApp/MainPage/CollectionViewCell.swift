//
//  CollectionViewCell.swift
//  CineworldApp
//
//  Created by ульяна on 29.03.23.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    let nameOfFilm = UILabel()
    let poster = UIImageView()
    let rating = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(item: Items) {
//        poster.image = image
        self.nameOfFilm.text = item.nameRu
        self.rating.text = item.ratingKinopoisk?.description
        guard let urlString = item.posterUrl,
              let url = URL(string: urlString) else { return }
        self.poster.kf.setImage(with: url)
    }
    
    func setUpUi() {
        
        poster.contentMode = UIView.ContentMode.scaleAspectFill
        poster.clipsToBounds = true
//        poster.center = self.contentView.center
        self.contentView.addSubview(poster)
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.heightAnchor.constraint(equalToConstant: 188).isActive = true
        poster.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        poster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        nameOfFilm.textColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        nameOfFilm.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameOfFilm.textAlignment = .left
        nameOfFilm.numberOfLines = 0
        self.contentView.addSubview(nameOfFilm)
        nameOfFilm.translatesAutoresizingMaskIntoConstraints = false

        nameOfFilm.heightAnchor.constraint(equalToConstant: 36).isActive = true
        nameOfFilm.topAnchor.constraint(equalTo: self.poster.bottomAnchor, constant: 8).isActive = true
        //nameOfFilm.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        nameOfFilm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nameOfFilm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        rating.textColor = UIColor.green
        rating.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        rating.textAlignment = .left
        rating.numberOfLines = 0
        self.contentView.addSubview(rating)
        rating.translatesAutoresizingMaskIntoConstraints = false
        
        rating.heightAnchor.constraint(equalToConstant: 18).isActive = true
        rating.topAnchor.constraint(equalTo: self.nameOfFilm.bottomAnchor, constant: 8).isActive = true
        rating.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        rating.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        rating.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
    }
}
