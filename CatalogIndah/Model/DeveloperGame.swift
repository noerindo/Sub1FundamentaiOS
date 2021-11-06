//
//  DeveloperGame.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

struct Developer: Codable, Identifiable{
    var id : Int
    var games : [DeveloperGameList]

    
    enum CodingKeys: String, CodingKey {
        case id
        case games
    }
}

struct DeveloperList: Codable {
    var results : [Developer]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct DeveloperGameList: Codable,Identifiable {
    var id : Int
    var name : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
