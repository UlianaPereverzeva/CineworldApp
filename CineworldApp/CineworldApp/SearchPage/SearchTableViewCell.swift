//
//  SearchTableViewCell.swift
//  CineworldApp
//
//  Created by ульяна on 3.04.23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    private var film = UILabel()
    private var poster = UIImageView()
    
    func configure(film: Films) {
        setUpUi()
        self.film.text = film.nameRu
        guard let imageUrl = film.posterUrlPreview,
              let url = URL(string: imageUrl) else { return }
        self.poster.kf.setImage(with: url)
    }
    
    func setUpUi() {
        
        self.poster.translatesAutoresizingMaskIntoConstraints = false
        self.poster.contentMode = .scaleAspectFit
        self.contentView.addSubview(poster)
        
        NSLayoutConstraint.activate([
            self.poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.poster.widthAnchor.constraint(equalToConstant: 60),
            self.poster.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        self.film.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.film.textColor = UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1.00)
        self.film.textAlignment = .left
        self.film.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.film)
        
        NSLayoutConstraint.activate([
            self.film.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 31),
            self.film.leadingAnchor.constraint(equalTo: self.poster.trailingAnchor, constant: 14),
            self.film.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            self.film.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
