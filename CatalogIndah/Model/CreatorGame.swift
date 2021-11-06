//
//  CreatorGame.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

struct CreatorList: Codable {
    var results : [Creator]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Creator: Codable, Identifiable{
    var id: Int
    var name: String
    var gamesCount: Int
    var image: String
    var backgroundImage: String
    var games: [DeveloperGameList]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gamesCount = "games_count"
        case image
        case backgroundImage = "image_background"
        case games
        
    }
}
