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
//Retrieving the Feed json result object
struct AlbumFeed: Codable{
    var feed: AlbumResult
}

//Retrieving the Array of Albums json object
struct AlbumResult: Codable{
    var results: [Album]
}

//Retrieving the Album value from Array of Albums json object
struct Album: Codable{
    var name: String
    var artistName: String
    var artworkUrl100: String
    var copyright: String
    var url: String
    var releaseDate: String
    var genres: [AlbumGenres]
}

//Retrieving the Genre from Album json object 
struct AlbumGenres: Codable{
    var genreId: String
    var name: String
    var url: String
}





