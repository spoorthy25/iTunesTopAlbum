//
//  AlbumModel.swift
//  AlbumGerne
//
//  Created by Spoorthy Kancharla on 1/3/20.
//  Copyright © 2020 Spoorthy Kancharla. All rights reserved.
//

import Foundation
import UIKit

/**
 AlbumModel - model which defines the Album values and parse the API reponse
 */
struct AlbumModel {
      var name: String
      var artistName: String
      var copyright: String
      var artworkUrl: String
      var releaseDate: String
      var albumUrl: String
      var genre: [Dictionary<String,Any>]
    
      init(_ dictionary: Dictionary<String,Any>) {
          self.name = dictionary["name"] as? String ?? ""
          self.artistName = dictionary["artistName"] as? String ?? ""
          self.artworkUrl = dictionary["artworkUrl100"] as? String ?? ""
          self.copyright = dictionary["copyright"] as? String ?? ""
          self.releaseDate = dictionary["releaseDate"] as? String ?? ""
          self.albumUrl = dictionary["url"] as? String ?? ""
          self.genre = dictionary["genres"] as? [Dictionary<String,Any>] ?? [Dictionary<String,Any>]()
     }
}



