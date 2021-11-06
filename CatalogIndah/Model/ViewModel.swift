//
//  ViewModel.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation
import UIKit

class GameDetailViewModel: ObservableObject {
    @Published var gameDetail = GameDetail(id: 0, name: "", released: "", backgroundImage: "", backgroundImageAdditional: "", rating: 0,  description: "")
    @Published var loading : Bool = false
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    func loadGameDataById(id : String){
        self.loading = true
        service.fetchGameById(gameId: id){gameDetail in
            
            guard let gameDetail = gameDetail else{
                return
            }
            
            
            DispatchQueue.main.async {
                self.loading = false
                self.gameDetail = gameDetail
            }
            
        }
    }
}
class GameListViewModel: ObservableObject {
    @Published var games =  GameList(results: [])
    @Published var loading = false
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    func loadGameData(){
        self.loading = true
        service.fetchGame{games in
            
            guard let games = games else{
                return
            }
            
            DispatchQueue.main.async {
                self.loading = false
                self.games.results = games
            }
            
        }
    }
}

class CreatorListViewModel: ObservableObject {
    @Published var creators = CreatorList(results: [])
    @Published var loading : Bool = false
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    func loadCreatorData(){
        self.loading = true
        service.fetchCreator{creators in
            self.loading = false
            guard let creators = creators else{
                return
            }
            self.creators.results = creators
        }
    }
}
