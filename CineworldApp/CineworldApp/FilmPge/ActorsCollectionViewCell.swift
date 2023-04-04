//
//  ActorsCollectionViewCell.swift
//  CineworldApp
//
//  Created by ульяна on 2.04.23.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {
    let name = UILabel()
    let photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(actorModel: ActorModel) {
        self.name.text = actorModel.nameRu
        guard let urlString = actorModel.posterUrl,
              let url = URL(string: urlString) else { return }
        self.photo.kf.setImage(with: url)
    }
    
    func setUpUi() {
        
        photo.contentMode = UIView.ContentMode.scaleAspectFill
        photo.clipsToBounds = true
        self.contentView.addSubview(photo)
        
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.heightAnchor.constraint(equalToConstant: 130).isActive = true
        photo.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        name.textColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        name.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        name.textAlignment = .left
        name.numberOfLines = 0
        self.contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false

        name.heightAnchor.constraint(equalToConstant: 36).isActive = true
        name.topAnchor.constraint(equalTo: self.photo.bottomAnchor, constant: 8).isActive = true
        //nameOfFilm.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
    }
}

