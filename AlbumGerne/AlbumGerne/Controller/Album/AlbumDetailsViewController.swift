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
    var albumDetails:Album?
    
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
        backButton.setTitle("Done", for: .normal)
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
        if let url = albumDetails?.url{
            if let imageUrl = URL(string: url){
                UIApplication.shared.open(imageUrl)
            }
        }
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
     
     let albumImageView:UIImageView = {
         let img = UIImageView()
         img.contentMode = .scaleAspectFill
         img.translatesAutoresizingMaskIntoConstraints = false
         return img
     }()
     
     let albumNameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0;
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         return label
     }()
     
     let albumArtistNameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0;
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         return label
     }()
        
     let copyrightLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0;
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         return label
    }()
        
     let releaseDateLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0;
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         return label
    }()
        
    let gerneNameLabel:UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 20)
         label.textColor = .black
         label.translatesAutoresizingMaskIntoConstraints = false
         label.numberOfLines = 0;
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         return label
    }()
        
    let button:UIButton = {
         let buttonRect = UIButton()
         buttonRect.backgroundColor = .blue
         buttonRect.layer.cornerRadius = 15
         buttonRect.setTitle("Open in iTunes", for: .normal)
         buttonRect.addTarget(self, action: #selector(openiTunes), for: .touchUpInside)
         buttonRect.translatesAutoresizingMaskIntoConstraints = false
         return buttonRect
    }()
        
     
              
 
}


extension AlbumDetailsViewController{
    
    /**
    setupAlbumView - create UI elements for displaying album name,artist,releasedate
    copyright
    */
    func setupAlbumView(){
       if let albumName = albumDetails?.name {
           albumNameLabel.text = "Album : \(albumName)"
       }
       
       if let artistName = albumDetails?.artistName {
           albumArtistNameLabel.text = "Artist : \(artistName)"
       }
       
       if let albumCopyright = albumDetails?.copyright {
           copyrightLabel.text = "Copyright : \(albumCopyright)"
       }
        
       if let albumReleaseDate = albumDetails?.releaseDate {
           releaseDateLabel.text = "Released On : \(albumReleaseDate)"
       }
       
       if let albumGenre = albumDetails?.genres {
           var name = ""
           for genre in albumGenre{
               if let genreName = genre.name as String?{
                   if(name.count > 0){
                       name = name + " , " + genreName
                   }else{
                       name = genreName
                   }
               }
           }
           gerneNameLabel.text = "Gerne : \(name)"
       }
       
       if let imageUrl = albumDetails?.artworkUrl100 {
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
       
       view.addSubview(albumImageView)
       
       //add constraints for the UIViews
       
       //add constraints for album image
       NSLayoutConstraint.activate([
           albumImageView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
           albumImageView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:50),
           albumImageView.topAnchor.constraint(equalTo:view.topAnchor,constant: 100)
       ])
       
       view.addSubview(scrollView)
       scrollView.addSubview(scrollViewContainer)
       scrollViewContainer.addArrangedSubview(albumNameLabel)
       scrollViewContainer.addArrangedSubview(albumArtistNameLabel)
       scrollViewContainer.addArrangedSubview(copyrightLabel)
       scrollViewContainer.addArrangedSubview(releaseDateLabel)
       scrollViewContainer.addArrangedSubview(gerneNameLabel)
       self.view.addSubview(button)
       
       //add constraints for UIViews
       NSLayoutConstraint.activate([
           
           //scrollview constraints
           scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
           scrollView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor,constant: 70),
           
           //scrollview container constraints
           scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 10),
           scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
           scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
           scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
           
           //button constraints
           button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
           button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
           button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20),
           button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
           button.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20)
           
       ])
    }
}

