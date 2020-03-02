//
//  AlbumViewController.swift
//  AlbumGerne
//
//  Created by Spoorthy Kancharla on 1/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import Foundation
import UIKit

/**
AlbumDetailsViewController - Album Detailed View Controller.
 Display the detailed view of Album
 Open itunes album when clicked button
*/
class AlbumDetailsViewController: UIViewController {
    var albumDetails:AlbumModel?
    var albumDetailsView = UIView()
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        
        //add back button
        addNavigationButton()
        
        //create ui elements to display album details
        setupAlbumView()
        
    }
    
    /**
        addNavigationButton -  add back button to navigate back to the Home page
     */
    func addNavigationButton() {
        let backButton = UIButton(type: .custom)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(backButton.tintColor, for: .normal)
        backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    /**
     backAction -  handle back button click
        remove this screen and move back to Home screen
     */
    @IBAction func backAction(_ sender: UIButton) {
        
      self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    /**
     openiTunes - open itunes app of the selected album
     */
    @objc func openiTunes(sender: UIButton) {
        if let url = albumDetails?.albumUrl{
            if let imageUrl = URL(string: url){
                UIApplication.shared.open(imageUrl)
            }
        }

    }
    
    
    let containerView:UIView = {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         view.clipsToBounds = true
         return view
     }()
     
     let albumImageView:UIImageView = {
         let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.translatesAutoresizingMaskIntoConstraints = false
         img.layer.cornerRadius = 35
         img.clipsToBounds = true
         return img
     }()
     
     let albumNameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     let albumArtistNameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
        
     let copyrightLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let releaseDateLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let gerneDateLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let button:UIButton = {
            let buttonRect = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 25))
            buttonRect.backgroundColor = .blue
            buttonRect.layer.cornerRadius = 15
            buttonRect.setTitle("Open in iTunes", for: .normal)
            buttonRect.addTarget(self, action: #selector(openiTunes), for: .touchUpInside)
            return buttonRect
        }()
        
     /**
     setupAlbumView - create UI elements for displaying album name,artist,releasedate
     copyright
     */
     func setupAlbumView(){
        if let albumName = albumDetails?.name {
            albumNameLabel.text = "Album : \(albumName)"
            albumNameLabel.numberOfLines = 0;
            albumNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        if let artistName = albumDetails?.artistName {
            albumArtistNameLabel.text = "Artist : \(artistName)"
            albumArtistNameLabel.numberOfLines = 0;
            albumArtistNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        if let albumCopyright = albumDetails?.copyright {
            
            copyrightLabel.text = "Copyright : \(albumCopyright)"
            copyrightLabel.numberOfLines = 0;
            copyrightLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
         
        if let albumReleaseDate = albumDetails?.releaseDate {
            releaseDateLabel.text = "Released On : \(albumReleaseDate)"
            releaseDateLabel.numberOfLines = 0;
            releaseDateLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
        
        if let albumGenre = albumDetails?.genre {
            let genre = albumGenre[0]
            if let genreName = genre["name"] as? String{
               gerneDateLabel.text = "Gerne : \(genreName)"
               gerneDateLabel.numberOfLines = 0;
               gerneDateLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            }
            
        }
        
        if let imageUrl = albumDetails?.artworkUrl {
            if let fileUrl = URL(string: imageUrl){
                DispatchQueue.main.async {
                    Utilities().downloadImage(from: fileUrl,completionHandler: { (data, error) in
                        DispatchQueue.main.async {
                            if let imageData = data{
                                self.albumImageView.image = UIImage(data: imageData )
                            }
                        }
                    })
                }
            }
        }

         self.view.addSubview(albumImageView)
         containerView.addSubview(albumNameLabel)
         containerView.addSubview(albumArtistNameLabel)
        containerView.addSubview(copyrightLabel)
        containerView.addSubview(releaseDateLabel)
        containerView.addSubview(gerneDateLabel)
         self.view.addSubview(containerView)
        self.view.addSubview(button)
         button.translatesAutoresizingMaskIntoConstraints = false

         button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         button.widthAnchor.constraint(equalToConstant: 200).isActive = true
         button.heightAnchor.constraint(equalToConstant: 35).isActive = true
         button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
         albumImageView.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
         albumImageView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:50).isActive = true
         albumImageView.topAnchor.constraint(equalTo:self.view.topAnchor,constant: 60).isActive = true
         albumImageView.bottomAnchor.constraint(equalTo:self.containerView.topAnchor, constant:-20).isActive = true
        
         containerView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10).isActive = true
         containerView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
         containerView.bottomAnchor.constraint(equalTo:self.button.topAnchor, constant:150).isActive = true
         
         albumNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         albumNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
         albumNameLabel.bottomAnchor.constraint(equalTo:self.albumArtistNameLabel.topAnchor,constant: -8).isActive = true
        albumNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 0).isActive = true
         
         albumArtistNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         albumArtistNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         albumArtistNameLabel.bottomAnchor.constraint(equalTo:self.copyrightLabel.topAnchor,constant: -8).isActive = true
        
         copyrightLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         copyrightLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
         copyrightLabel.bottomAnchor.constraint(equalTo:self.releaseDateLabel.topAnchor,constant: -8).isActive = true
        
         releaseDateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         releaseDateLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
         releaseDateLabel.bottomAnchor.constraint(equalTo:self.gerneDateLabel.topAnchor,constant: -8).isActive = true
        
         gerneDateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
         gerneDateLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
     }           
 
}
