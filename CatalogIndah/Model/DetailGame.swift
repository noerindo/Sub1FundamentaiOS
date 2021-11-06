//
//  DetailGame.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

struct GameDetail: Decodable, Identifiable{
    var id : Int
    var name : String
    var released : String
    var backgroundImage : String
    var backgroundImageAdditional : String
    var rating : Float
    var description : String

}
