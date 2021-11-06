//
//  Game.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Float

}
struct GameList: Decodable{
    var results : [Game]
}
