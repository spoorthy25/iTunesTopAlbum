    //
    //  AlbumTableViewCell.swift
    //  AlbumGerne
    //
    //  Created by Spoorthy Kancharla on 1/3/20.
    //  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
    //
    
    
    import Foundation
    import UIKit
    
    /**
     AlbumTableViewCell - create TableViewCell for displaying album title,artistname and album thumbnail
     */
    class AlbumTableViewCell: UITableViewCell {
        
        let albumImageView = UIImageView()
        let albumNameLabel = UILabel()
        let albumArtistNameLabel = UILabel()
        /**
         create tableview cell and add uielements to the tableviewcell
         add layout constraints
         */
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
        
        func setupViews() {
            albumImageView.translatesAutoresizingMaskIntoConstraints = false
            albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
            albumArtistNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // add views
            contentView.addSubview(albumImageView)
            contentView.addSubview(albumNameLabel)
            contentView.addSubview(albumArtistNameLabel)
            
            // setup views properties
            albumImageView.contentMode = .scaleAspectFit
            
            albumNameLabel.font = .boldSystemFont(ofSize: 28.0)
            albumNameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            albumNameLabel.numberOfLines = 0
            albumNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            albumArtistNameLabel.textColor = .darkGray
            albumArtistNameLabel.font = albumArtistNameLabel.font.withSize(20)
            albumArtistNameLabel.numberOfLines = 0
            albumArtistNameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            
            // setup views constraints
            let marginGuide = contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                // album Image
                albumImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                albumImageView.trailingAnchor.constraint(equalTo: marginGuide.leadingAnchor,constant: 60),
                albumImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
                albumImageView.bottomAnchor.constraint(lessThanOrEqualTo: marginGuide.topAnchor,constant: 80),
                
                // album name
                albumNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
                albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 8),
                albumNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 8),
                
                // album artist name
                albumArtistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
                albumArtistNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 8),
                albumArtistNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor,constant: 8),
                albumArtistNameLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor,constant: -8),
                ])
        }
        
    }
