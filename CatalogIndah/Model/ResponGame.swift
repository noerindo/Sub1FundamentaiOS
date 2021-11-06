//
//  ResponGame.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

struct GameResponseList: Codable {
    let results : [GameResponse]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    struct GameResponse: Codable {
        let id: Int?
        let name: String?
        let released: String?
        let backgroundImage: String?
        let rating: Float?
 
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case released
            case backgroundImage = "background_image"
            case rating

        }
    }
}
class Square {
  var height: Int = 0
  var width: Int {
    return height
  }
}

struct GameDetailResponse: Codable {
    let id : Int?
    let name : String?
    let released : String?
    let backgroundImage : String?
    let backgroundImageAdditional : String?
    let rating : Float?
    let description : String?

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case rating
        case description = "description_raw"

    }

    
    struct GamePublisherResponse : Codable {
        let id : Int?
        let name : String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }

}
