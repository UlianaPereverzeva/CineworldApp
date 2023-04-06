//
//  MainPageViewController.swift
//  CineworldApp
//
//  Created by ульяна on 6.02.23.
//

import UIKit
import Kingfisher
import RealmSwift


class MainPageViewController: UIViewController {
    
    var realmService = RealmService()
    var favoriteslist : Favoriteslist?
    var mainImageOfFilm = UIImageView()
    var blackGradient = UIImageView()
    var nameOfFilm = UILabel()
    var logoOfFilm = UIImageView()
    var numberOfFilmRating = UILabel()
    var filmRating = UILabel()
    var premieresID: Int?
    var parametrsAboutFilm = UILabel()
    var shortFilmDescription = UILabel()
    var FilmDescription = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var watchFilmButton: UIButton!
    var saveFilmButton: UIButton!
    var favoritesButton: UIButton!

    var FirstCollectionView: UICollectionView!
    var SecondCollectionView: UICollectionView!
    var ThirdCollectionView: UICollectionView!
    var genres = [Genre]()
    var countries = [Countries]()
    var arrayOfGenresWith0ID = [Items]()
    var arrayOfGenresWith1ID = [Items]()
    var arrayOfGenresWith2ID = [Items]()
    var nameOfSection0 = UILabel()
    var nameOfSection1 = UILabel()
    var nameOfSection2 = UILabel()

    
    var filmID = [658, 6379, 729, 740, 651, 652, 656, 659, 661, 664, 666, 688, 689, 447301].randomElement() // Int.random(in: 600...700) //658//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setUpUI()
        
        setUpFirstCollectionView()
        setUpSecondCollectionView()
        setUpThirdCollectionView()
        
        getGenres()
        getPostersAndStill()
        getDataAboutFilm()

        navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        navigationController?.navigationBar.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        watchFilmButton.layer.cornerRadius = watchFilmButton.frame.height/2
        //saveFilmButton.layer.cornerRadius = watchFilmButton.frame.height/2
        favoritesButton.layer.cornerRadius = watchFilmButton.frame.height/2

    }
    
    func setupScrollView(){
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        scrollView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        }
    
    private func setUpFirstCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 130, height: 240)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal

        FirstCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        FirstCollectionView.dataSource = self
        FirstCollectionView.delegate = self
        FirstCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "filmCell")
        FirstCollectionView.showsVerticalScrollIndicator = false
        FirstCollectionView.backgroundColor = .clear
        contentView.addSubview(FirstCollectionView)
        FirstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        FirstCollectionView.topAnchor.constraint(equalTo: self.nameOfSection0.bottomAnchor, constant: 8).isActive = true
        FirstCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        FirstCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        FirstCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
     }
    
    private func setUpSecondCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 240)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal

        SecondCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        SecondCollectionView.dataSource = self
        SecondCollectionView.delegate = self
        SecondCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "filmCell")
        SecondCollectionView.showsVerticalScrollIndicator = false
        SecondCollectionView.backgroundColor = .clear
        contentView.addSubview(SecondCollectionView)
        SecondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        SecondCollectionView.topAnchor.constraint(equalTo: self.nameOfSection1.bottomAnchor, constant: 14).isActive = true
        SecondCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        SecondCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        SecondCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true

    }
    
    private func setUpThirdCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 130, height: 240)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal

        ThirdCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        ThirdCollectionView.dataSource = self
        ThirdCollectionView.delegate = self
        ThirdCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "filmCell")
        ThirdCollectionView.showsVerticalScrollIndicator = false
        ThirdCollectionView.backgroundColor = .clear
        contentView.addSubview(ThirdCollectionView)
        ThirdCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        ThirdCollectionView.topAnchor.constraint(equalTo: self.nameOfSection2.bottomAnchor, constant: 14).isActive = true
        ThirdCollectionView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        ThirdCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        ThirdCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        ThirdCollectionView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant:  -14).isActive = true

    }
        
    private func setUpUI() {
       
        mainImageOfFilm.contentMode = UIView.ContentMode.scaleAspectFill
        mainImageOfFilm.clipsToBounds = true
        mainImageOfFilm.center = self.view.center
        self.contentView.addSubview(mainImageOfFilm)
        
        mainImageOfFilm.translatesAutoresizingMaskIntoConstraints = false
        
        mainImageOfFilm.heightAnchor.constraint(equalToConstant: 480).isActive = true
        mainImageOfFilm.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainImageOfFilm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        mainImageOfFilm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        let background = UIImage(named: "black")
        blackGradient.contentMode = UIView.ContentMode.scaleAspectFill
        blackGradient.image = background
        self.contentView.addSubview(blackGradient)
        
        blackGradient.translatesAutoresizingMaskIntoConstraints = false
        
        blackGradient.topAnchor.constraint(equalTo: mainImageOfFilm.topAnchor, constant: 291).isActive = true
        blackGradient.bottomAnchor.constraint(equalTo: mainImageOfFilm.bottomAnchor).isActive = true
        blackGradient.trailingAnchor.constraint(equalTo: mainImageOfFilm.trailingAnchor).isActive = true
        blackGradient.leadingAnchor.constraint(equalTo: mainImageOfFilm.leadingAnchor).isActive = true
        
        logoOfFilm.contentMode = UIView.ContentMode.scaleAspectFit
        logoOfFilm.clipsToBounds = true
        logoOfFilm.center = self.view.center
        self.contentView.addSubview(logoOfFilm)
        
        logoOfFilm.translatesAutoresizingMaskIntoConstraints = false
        
        logoOfFilm.topAnchor.constraint(equalTo: self.mainImageOfFilm.bottomAnchor, constant: -50).isActive = true
        logoOfFilm.heightAnchor.constraint(equalToConstant: 75).isActive = true
        logoOfFilm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -74).isActive = true
        logoOfFilm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 74).isActive = true
        
        numberOfFilmRating.numberOfLines = 0
        numberOfFilmRating.textColor = .green
        numberOfFilmRating.textAlignment = .center
        numberOfFilmRating.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        numberOfFilmRating.translatesAutoresizingMaskIntoConstraints = false
        
        filmRating.text = "Rating:"
        filmRating.numberOfLines = 0
        filmRating.textColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        filmRating.textAlignment = .center
        filmRating.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        filmRating.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 2.0
        
        stackView.addArrangedSubview(filmRating)
        stackView.addArrangedSubview(numberOfFilmRating)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.logoOfFilm.bottomAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: -147).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 147).isActive = true
        
        parametrsAboutFilm.numberOfLines = 0
        parametrsAboutFilm.textColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        parametrsAboutFilm.textAlignment = .center
        parametrsAboutFilm.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.contentView.addSubview(parametrsAboutFilm)
        
        parametrsAboutFilm.translatesAutoresizingMaskIntoConstraints = false
        
        parametrsAboutFilm.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8).isActive = true
        parametrsAboutFilm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -70).isActive = true
        parametrsAboutFilm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 70).isActive = true
        
        let watchButton = UIButton(type: .system)
        watchButton.setTitle("Смотреть", for: .normal)
        watchButton.addTarget(self, action: #selector(watchButtonAction(_:)), for: .touchUpInside)
        watchButton.setTitleColor(UIColor.black, for: .normal)
        watchButton.backgroundColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        watchButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.watchFilmButton = watchButton
        self.watchFilmButton.translatesAutoresizingMaskIntoConstraints = false
        watchFilmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

//        let saveButton = UIButton(type: .system)
//
//        let origImage = UIImage(named: "download")
//        let image = origImage?.withRenderingMode(.alwaysTemplate)
//        saveButton.setImage(image, for: .normal)
//        saveButton.tintColor = .white
//
//        saveButton.addTarget(self, action: #selector(watchButtonAction(_:)), for: .touchUpInside)
//        saveButton.setTitleColor(UIColor.white, for: .normal)
//        saveButton.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
//        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        self.saveFilmButton = saveButton
//        self.saveFilmButton.translatesAutoresizingMaskIntoConstraints = false
//        saveFilmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        saveFilmButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let addToFavorites = UIButton(type: .system)
        
        let favoritesImage = UIImage(named: "hert")
        let favoriteImage = favoritesImage?.withRenderingMode(.alwaysTemplate)
        addToFavorites.setImage(favoriteImage, for: .normal)
        addToFavorites.tintColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        //addToFavorites.imageView?.contentMode = .scaleAspectFit
        addToFavorites.addTarget(self, action: #selector(isFavoriteButtonTapped(_:)), for: .touchUpInside)
        addToFavorites.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        
        self.favoritesButton = addToFavorites
        self.favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        favoritesButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buttonStackView = UIStackView()
        buttonStackView.axis = NSLayoutConstraint.Axis.horizontal
        buttonStackView.distribution  = UIStackView.Distribution.fillProportionally
        buttonStackView.alignment = UIStackView.Alignment.fill
        buttonStackView.spacing = 14.0
        
        buttonStackView.addArrangedSubview(watchFilmButton)
       // buttonStackView.addArrangedSubview(saveFilmButton)
        buttonStackView.addArrangedSubview(favoritesButton)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(buttonStackView)
        
        buttonStackView.topAnchor.constraint(equalTo: self.parametrsAboutFilm.bottomAnchor, constant: 14).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: -80).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 80).isActive = true
        
        shortFilmDescription.numberOfLines = 0
        shortFilmDescription.textColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        shortFilmDescription.textAlignment = .center
        shortFilmDescription.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.contentView.addSubview(shortFilmDescription)
        
        shortFilmDescription.translatesAutoresizingMaskIntoConstraints = false
        
        shortFilmDescription.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 14).isActive = true
        shortFilmDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -60).isActive = true
        shortFilmDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 60).isActive = true
        
        nameOfSection0.numberOfLines = 0
        nameOfSection0.textColor = .white
        nameOfSection0.textAlignment = .left
        nameOfSection0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.contentView.addSubview(nameOfSection0)
        
        nameOfSection0.translatesAutoresizingMaskIntoConstraints = false
        
        nameOfSection0.topAnchor.constraint(equalTo: shortFilmDescription.bottomAnchor, constant: 14).isActive = true
        nameOfSection0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nameOfSection0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        
        nameOfSection1.numberOfLines = 0
        nameOfSection1.textColor = .white
        nameOfSection1.textAlignment = .left
        nameOfSection1.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.contentView.addSubview(nameOfSection1)
        
        nameOfSection1.translatesAutoresizingMaskIntoConstraints = false
        
        nameOfSection1.topAnchor.constraint(equalTo: nameOfSection0.bottomAnchor, constant:268).isActive = true
        nameOfSection1.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nameOfSection1.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        
        nameOfSection2.numberOfLines = 0
        nameOfSection2.textColor = .white
        nameOfSection2.textAlignment = .left
        nameOfSection2.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.contentView.addSubview(nameOfSection2)
        
        nameOfSection2.translatesAutoresizingMaskIntoConstraints = false
        nameOfSection2.topAnchor.constraint(equalTo: nameOfSection1.bottomAnchor, constant:268).isActive = true
        nameOfSection2.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        nameOfSection2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
    }
    
    @objc func watchButtonAction(_ sender:UIButton!) {
        let vc = FilmViewController()
        vc.filmID = filmID
        //vc.mainImageOfFilm.image = mainImageOfFilm.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func isFavoriteButtonTapped(_ sender:UIButton!) {
        
        guard let name = nameOfFilm.text else { return }
        guard let image = mainImageOfFilm.image else { return }
        
        let isFilmExist = RealmManager.shared.objectExist(id: name)
       
        
        if favoriteslist == nil {
            favoriteslist = Favoriteslist()
        }
        
        if !isFilmExist {
            
            favoriteslist?.name = name
            let data = NSData(data: image.jpegData(compressionQuality: 0.9)!)
            favoriteslist?.poster = data
            
            guard let favoriteslist = favoriteslist else { return }
            try? realmService.localRealm.write {
                realmService.localRealm.add(favoriteslist, update: .all)
            }
        }
    }
    
    private func getPostersAndStill() {
        let poster = "POSTER"
        guard let filmID = filmID else { return }
        NetworkService.fetchPosters(type: poster, filmID: filmID) { poster, error in
            guard let poster = poster?.items[0].imageUrl,
            let url = URL(string: poster) else { return }
            self.mainImageOfFilm.kf.setImage(with: url)
        }
    }
    
    private func getDataAboutFilm() {
        guard let filmID = filmID else { return }
        NetworkService.fetchDataAboutFilm(filmID: filmID) { filmModel, error in
            guard let filmModel = filmModel,
                  let name = filmModel.nameRu,
                  let year = filmModel.year,
                  let genres = filmModel.genres[0].genre,
                  let countries = filmModel.countries[0].country,
                  let filmLength = filmModel.filmLength,
                  let ratingAgeLimits = filmModel.ratingAgeLimits,
                  let shortDescription = filmModel.shortDescription,
                  let description = filmModel.description,
                  let rating = filmModel.ratingKinopoisk,
                  let urlString = filmModel.logoUrl,
                  let url = URL(string: urlString) else { return }
            self.logoOfFilm.kf.setImage(with: url)
            self.numberOfFilmRating.text = rating.description
            self.parametrsAboutFilm.text = "\(year), \(genres), \(countries),\n\(filmLength) мин, \(ratingAgeLimits)+"
            self.shortFilmDescription.text = shortDescription
            self.FilmDescription.text = description
            self.nameOfFilm.text = name
            let image: UIImage?
            if RealmManager.shared.objectExist(id: name) {
                image = UIImage(named: "fullHeart")
            } else {
                image = UIImage(named: "hert")
            }
            self.favoritesButton.setImage(
                image, for: .normal)
        }
        
    }
    
    private func getPosterByGenres() {
        
        guard let genresID0 = self.genres[0].id,
              let genresID1 = self.genres[1].id,
              let genresID2 = self.genres[2].id else { return }

        NetworkService.fetchPosterByIdOfGenres(genresID: genresID0) { films, error in
            guard let films = films,
                  let array = films.items else {return}
            self.arrayOfGenresWith0ID = array
            self.nameOfSection0.text = self.genres[0].genre?.description
            self.FirstCollectionView.reloadData()
        }
        
        NetworkService.fetchPosterByIdOfGenres(genresID: genresID1) { films, error in
            guard let films = films,
                  let array = films.items else {return}
            self.arrayOfGenresWith1ID = array
            self.nameOfSection1.text = self.genres[1].genre?.description
            self.SecondCollectionView.reloadData()
        }
        
        NetworkService.fetchPosterByIdOfGenres(genresID: genresID2) { films, error in
            guard let films = films,
                  let array = films.items else {return}
            self.arrayOfGenresWith2ID = array
            self.nameOfSection2.text = self.genres[2].genre?.description
            self.ThirdCollectionView.reloadData()
        }
    }
    
    private func getGenres() {
        
        NetworkService.fetchArraysOfGenresAndCountries { genres, error in
            guard let genres = genres else {return}
            self.genres = genres.genres
            self.getPosterByGenres()
        }
    }
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return arrayOfGenresWith0ID.count
        } else if section == 1 {
            return arrayOfGenresWith1ID.count
        } else {
            return arrayOfGenresWith2ID.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == FirstCollectionView {
            let item = arrayOfGenresWith0ID[indexPath.item]
            cell.setUpCell(item: item )
        } else if collectionView == SecondCollectionView {
            let item1 = arrayOfGenresWith1ID[indexPath.item]
            cell.setUpCell(item: item1 )
        } else if collectionView == ThirdCollectionView {
            let item2 = arrayOfGenresWith2ID[indexPath.item]
            cell.setUpCell(item: item2 )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = FilmViewController()
        
        if indexPath.section == 0 {
            let firstCollectionArray = arrayOfGenresWith0ID[indexPath.item]
            guard let id = firstCollectionArray.kinopoiskId else { return }
            vc.filmID = id
//            guard let urlString = firstCollectionArray.posterUrl,
//                  let url = URL(string: urlString) else { return }
//            vc.mainImageOfFilm.kf.setImage(with: url)
            
        } else if indexPath.section == 1 {
            let secondCollectionArray = arrayOfGenresWith1ID[indexPath.item]
            guard let id = secondCollectionArray.kinopoiskId else { return }
            vc.filmID = id
           
//            guard let urlString = secondCollectionArray.posterUrl,
//                  let url = URL(string: urlString) else { return }
//            vc.mainImageOfFilm.kf.setImage(with: url)
        } else {
            let thirdCollectionArray = arrayOfGenresWith2ID[indexPath.item]
            guard let id = thirdCollectionArray.kinopoiskId else { return }
            vc.filmID = id

//            guard let urlString = thirdCollectionArray.posterUrl,
//                  let url = URL(string: urlString) else { return }
//            vc.mainImageOfFilm.kf.setImage(with: url)
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

    


