//
//  SubclassedCollectionViewCell.swift
//  CineworldApp
//
//  Created by ульяна on 31.03.23.
//

import UIKit
import AVFoundation


class SubclassedCollectionViewCell: UICollectionViewCell {
    
    var videoUrl = UILabel()
    var image = UIImageView()
    var playImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(still: Item ) {
        guard let urlString = still.previewUrl,
              let url = URL(string: urlString) else { return }
        self.image.kf.setImage(with: url)
    }
    
    func setUpUi() {
        
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        self.contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 130).isActive = true
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        playImage.contentMode = UIView.ContentMode.scaleAspectFill
        playImage.clipsToBounds = true
        let image = UIImage(named: "play")
        self.playImage.image = image
        self.contentView.addSubview(playImage)
        self.playImage.translatesAutoresizingMaskIntoConstraints = false

        playImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        playImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        playImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45).isActive = true
        playImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60).isActive = true
        playImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60).isActive = true
    
    }
    
//    @objc func playButtonAction(_ sender:UIButton!) {
////        let vc = FilmViewController()
////        vc.filmID = filmID
////        vc.mainImageOfFilm = mainImageOfFilm
////        vc.logoOfFilm = logoOfFilm
////        vc.parametrsAboutFilm = parametrsAboutFilm
////        vc.numberOfFilmRating = numberOfFilmRating
////        vc.filmDescription = FilmDescription
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(playerView)
//        playerView.translatesAutoresizingMaskIntoConstraints = false
//        playerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        playerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
//        playerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        playerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
//
//    var playerView: PlayerView = {
//        var player = PlayerView()
//        player.backgroundColor = .lightGray
//        return player
//    }()
//
//    var videoPlayer: AVPlayer? = nil
//
//
//    func playVideo(videos: Items) {
//        let video = videos.url
////        self.videoUrl.text = videos.url
//        guard let path = Bundle.main.path(forResource: video, ofType:"mp4") else {
//            debugPrint("video.m4v not found")
//            return
//        }
//        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
//        videoPlayer?.playImmediately(atRate: 1)
//        playerView.player = videoPlayer
//    }
//
//    func stopVideo() {
//        playerView.player?.pause()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

}
