//
//  FilmViewController.swift
//  CineworldApp
//
//  Created by ульяна on 31.03.23.
//

import UIKit

import WebKit

class FilmViewController: UIViewController {
    var favoriteslist : Favoriteslist?
    var realmService = RealmService()

    var mainImageOfFilm = UIImageView()
    var blackGradient = UIImageView()
    var favorites: UIButton!
    var nameOfFilm = UILabel()
    var logoOfFilm = UIImageView()
    var numberOfFilmRating = UILabel()
    var filmRating = UILabel()
    var premieresID: Int?
    var parametrsAboutFilm = UILabel()
    var filmDescription = UILabel()
    var trailerLabel = UILabel()
    var actorsLabel = UILabel()
    var arrayActorsOfPosters : String?
    var arrayOfActors = [ActorModel]()
    
    var arrayOfVideoURL = [String]()
    var arrayOfItems = [Item]()
    //var AVPlayerController = AVPlayerViewController()
    //var playerView : AVPlayer?
    
    var videoCollectionView: UICollectionView!
    var actorCollectionView: UICollectionView!
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var filmID: Int!
    
    var items: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setUpUI()
        setUpVideoCollectionView()
        getPosters()

        getData()
        getVideos()
        setUpActorsCollectionView()
        getActors()
        getStill()
//        setUpVideoCollectionView()
//        getVideos()
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem?.tintColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        navigationController?.navigationBar.backgroundColor = .clear
        //navigationItem.backBarButtonItem?.tintColor = .white
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        // navigationController?.isNavigationBarHidden = true
        scrollView.contentInsetAdjustmentBehavior = .never
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
    
    private func setUpVideoCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 130)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        videoCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        videoCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "videoCell")
        videoCollectionView.showsVerticalScrollIndicator = false
        videoCollectionView.backgroundColor = .clear
        contentView.addSubview(videoCollectionView)
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        videoCollectionView.topAnchor.constraint(equalTo: self.trailerLabel.bottomAnchor, constant: 20).isActive = true
        videoCollectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        videoCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        videoCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        //videoCollectionView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setUpActorsCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        actorCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        actorCollectionView.register(ActorsCollectionViewCell.self, forCellWithReuseIdentifier: "actorCell")
        actorCollectionView.showsVerticalScrollIndicator = false
        actorCollectionView.backgroundColor = .clear
        contentView.addSubview(actorCollectionView)
        actorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        actorCollectionView.topAnchor.constraint(equalTo: self.actorsLabel.bottomAnchor, constant: 20).isActive = true
        actorCollectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        actorCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        actorCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        actorCollectionView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setUpUI() {
        
        mainImageOfFilm.contentMode = UIView.ContentMode.scaleAspectFill
        mainImageOfFilm.clipsToBounds = true
        mainImageOfFilm.center = self.view.center
        self.contentView.addSubview(mainImageOfFilm)
        
        mainImageOfFilm.translatesAutoresizingMaskIntoConstraints = false
        
        mainImageOfFilm.heightAnchor.constraint(equalToConstant: 844).isActive = true
        mainImageOfFilm.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainImageOfFilm.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        mainImageOfFilm.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        let background = UIImage(named: "bigBlack")
        blackGradient.contentMode = UIView.ContentMode.scaleAspectFill
        blackGradient.image = background
        self.contentView.addSubview(blackGradient)
        
        blackGradient.translatesAutoresizingMaskIntoConstraints = false
        
        blackGradient.topAnchor.constraint(equalTo: mainImageOfFilm.topAnchor).isActive = true
        blackGradient.bottomAnchor.constraint(equalTo: mainImageOfFilm.bottomAnchor).isActive = true
        blackGradient.trailingAnchor.constraint(equalTo: mainImageOfFilm.trailingAnchor).isActive = true
        blackGradient.leadingAnchor.constraint(equalTo: mainImageOfFilm.leadingAnchor).isActive = true
        
        logoOfFilm.contentMode = UIView.ContentMode.scaleAspectFit
        logoOfFilm.clipsToBounds = true
        logoOfFilm.center = self.view.center
        self.contentView.addSubview(logoOfFilm)
        
        logoOfFilm.translatesAutoresizingMaskIntoConstraints = false
        
        logoOfFilm.topAnchor.constraint(equalTo: self.mainImageOfFilm.topAnchor, constant: 200).isActive = true
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
        
        let addToFavorites = UIButton(type: .system)
        
        let favoritesImage = UIImage(named: "hert")
        let favoriteImage = favoritesImage?.withRenderingMode(.alwaysTemplate)
        addToFavorites.setImage(favoriteImage, for: .normal)
        addToFavorites.tintColor = UIColor(red: 0.76, green: 0.89, blue: 0.23, alpha: 1.00)
        //addToFavorites.imageView?.contentMode = .scaleAspectFit
        addToFavorites.addTarget(self, action: #selector(isFavoriteButtonTapped(_:)), for: .touchUpInside)
        addToFavorites.backgroundColor = .clear
        
        self.contentView.addSubview(addToFavorites)
        self.favorites = addToFavorites
        self.favorites.translatesAutoresizingMaskIntoConstraints = false
        favorites.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //favorites.widthAnchor.constraint(equalToConstant: 50).isActive = true
        favorites.topAnchor.constraint(equalTo: parametrsAboutFilm.bottomAnchor, constant: 14).isActive = true
        favorites.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -170).isActive = true
        favorites.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 170).isActive = true

        filmDescription.numberOfLines = 0
        filmDescription.textColor = .white //UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
        filmDescription.textAlignment = .left
        filmDescription.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.contentView.addSubview(filmDescription)
        
        filmDescription.translatesAutoresizingMaskIntoConstraints = false
        
        filmDescription.topAnchor.constraint(equalTo: favorites.bottomAnchor, constant: 14).isActive = true
        filmDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        filmDescription.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        
        trailerLabel.text = "Трейлеры"
        trailerLabel.numberOfLines = 0
        trailerLabel.textColor = .white
        trailerLabel.textAlignment = .left
        trailerLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(trailerLabel)
        
        trailerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trailerLabel.topAnchor.constraint(equalTo: filmDescription.bottomAnchor, constant: 14).isActive = true
        trailerLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        trailerLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
        
        actorsLabel.text = "Актеры"
        actorsLabel.numberOfLines = 0
        actorsLabel.textColor = .white
        actorsLabel.textAlignment = .left
        actorsLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentView.addSubview(actorsLabel)
        
        actorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        actorsLabel.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 170).isActive = true
        actorsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        actorsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14).isActive = true
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
    
    func getData() {
        //let vc = FilmViewController()
        guard let filmID = filmID else { return }

        NetworkService.fetchLogoOfFilm(filmID: filmID) { filmModel, error in
            guard let filmModel = filmModel,
                  let description = filmModel.description,
                  let name = filmModel.nameRu,
                  let rating = filmModel.ratingKinopoisk,
                  let year = filmModel.year,
                  let genres = filmModel.genres[0].genre,
                  let countries = filmModel.countries[0].country,
                  let filmLength = filmModel.filmLength,
                  let ratingAgeLimits = filmModel.ratingAgeLimits,
                  let urlString = filmModel.logoUrl,
            let url = URL(string: urlString) else { return }
            self.logoOfFilm.kf.setImage(with: url)
            self.filmDescription.text = description
            self.parametrsAboutFilm.text = "\(year), \(genres), \(countries),\n\(filmLength) мин, \(ratingAgeLimits)+"
            self.numberOfFilmRating.text = rating.description
            let image: UIImage?
            if RealmManager.shared.objectExist(id: name) {
                image = UIImage(named: "fullHeart")
            } else {
                image = UIImage(named: "hert")
            }
            self.favorites.setImage(
                image, for: .normal)
        }
    }
    
    func getVideos() {
        guard let filmID = filmID else { return }
        NetworkService.fetchVideo(filmID: filmID) { videoModel, error in
            guard let videoModel = videoModel,
                  let arrayOfVideos = videoModel.items else { return }
            for i in arrayOfVideos {
                guard let video = i.url else { return }
                self.arrayOfVideoURL.append(video)
            }
        }
    }
    
    private func getPosters() {
        let poster = "POSTER"
        guard let filmID = filmID else { return }
        NetworkService.fetchPosters(type: poster, filmID: filmID) { poster, error in
            guard let poster = poster?.items[0].imageUrl,
            let url = URL(string: poster) else { return }
            self.mainImageOfFilm.kf.setImage(with: url)
        }
    }
    
    func getStill() {
        let still = "STILL"
        guard let filmID = filmID else { return }
        
        NetworkService.fetchPosters(type: still, filmID: filmID) { still, error in
            guard let still = still else { return }
            let items = still.items
            self.arrayOfItems = items
            self.videoCollectionView.reloadData()
        }
    }
    
    func videoUrl(url: String) {
        
        guard let url = URL(string: url) else { return }
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        webView.load(URLRequest(url: url))
    }
    
    func getActors() {
        guard let filmID = filmID else { return }
        NetworkService.fetchActors(filmID: filmID) { actorModel, error in
            guard let actorModel = actorModel else { return }
            self.arrayOfActors = actorModel
            self.actorCollectionView.reloadData()
        }
    }
}

extension FilmViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return arrayOfVideoURL.count
        } else {
            return arrayOfActors.count
        }
        //ayOfVideoURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == videoCollectionView  {
            guard let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            //let video = arrayOfVideoURL[indexPath.item]
            let still = arrayOfItems[indexPath.item]
            videoCell.configureCell(still: still)
            return videoCell
        } else   {
            guard let actorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCell", for: indexPath) as? ActorsCollectionViewCell else {
                return UICollectionViewCell()
            }
            let arrayOfActors = arrayOfActors[indexPath.item]
            actorCell.configureCell(actorModel: arrayOfActors)
            return actorCell
        }
    }
    //        guard let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as? SubclassedCollectionViewCell else {
    //            return UICollectionViewCell()
    //        }
    //
    //        //let video = arrayOfVideoURL[indexPath.item]
    //        let still = arrayOfItems[indexPath.item]
    //        videoCell.configureCell(still: still)
    //
    //        //return videoCell
    //
    //        guard let actorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCell", for: indexPath) as? ActorsCollectionViewCell else {
    //            return UICollectionViewCell()
    //        }
    //        let arrayOfActors = arrayOfActors[indexPath.item]
    //        actorCell.configureCell(actorModel: arrayOfActors)
    //
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoData = arrayOfVideoURL[indexPath.item]
        videoUrl(url: videoData)
    }
}

    
