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
        
        /**
         create tableview cell and add uielements to the tableviewcell
         add layout constraints
         */
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.contentView.addSubview(albumImageView)
            containerView.addSubview(albumNameLabel)
            containerView.addSubview(albumArtistNameLabel)
            self.contentView.addSubview(containerView)
            
            albumImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor) .isActive = true
            albumImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            albumImageView.bottomAnchor.constraint(equalTo:self.contentView.topAnchor, constant:100).isActive = true
            albumImageView.widthAnchor.constraint(equalToConstant:80).isActive = true
            albumImageView.heightAnchor.constraint(equalToConstant:80).isActive = true
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: albumArtistNameLabel.bottomAnchor).isActive = true
            albumNameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
            albumNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            albumNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            
            albumArtistNameLabel.topAnchor.constraint(equalTo:self.albumNameLabel.bottomAnchor).isActive = true
            albumArtistNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            albumArtistNameLabel.topAnchor.constraint(equalTo:self.albumNameLabel.bottomAnchor).isActive = true
            albumArtistNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
        
    }
