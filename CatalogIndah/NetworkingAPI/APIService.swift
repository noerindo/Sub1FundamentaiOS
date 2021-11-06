//
//  APIService.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import Foundation

protocol ServiceProtocol {
    func fetchGame(completion: @escaping ([Game]?) -> Void)
    func fetchGameById(gameId : String,completion: @escaping (GameDetail?) -> Void)
    func fetchDeveloper(completion: @escaping ([Developer]?) -> Void)
    func fetchCreator(completion: @escaping ([Creator]?) -> Void)
}

fileprivate let baseUrl = "https://api.rawg.io/api/"

class APIService : ServiceProtocol {
    func fetchDeveloper(completion: @escaping ([Developer]?) -> Void) {
        guard let urlLink = URL(string: "\(baseUrl)developers?key=0cfaaba11cb543ee824e63a476ee4df4") else {return}
        URLSession.shared.dataTask(with: urlLink){ (data, _, _) in
            guard let data = data else{
                completion(nil)
                return
            }
            guard let developer = try? JSONDecoder().decode(DeveloperList.self, from: data) else{
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(developer.results)
            }
        }.resume()
    }
    
    func fetchCreator(completion: @escaping ([Creator]?) -> Void) {
        guard let urlLink = URL(string: "\(baseUrl)creators?key=0cfaaba11cb543ee824e63a476ee4df4") else {return}
        URLSession.shared.dataTask(with: urlLink){ (data, _, _) in
            guard let data = data else{
                completion(nil)
                return
            }
            guard let creator = try? JSONDecoder().decode(CreatorList.self, from: data) else{
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(creator.results)
            }
        }.resume()
    }
    
    func fetchGameById(gameId: String, completion: @escaping (GameDetail?) -> Void) {
        guard let urlLink = URL(string: "\(baseUrl)games/\(gameId)?key=0cfaaba11cb543ee824e63a476ee4df4") else {return}
        URLSession.shared.dataTask(with: urlLink){ (data, _, _) in
            guard let data = data else{
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(GameDetailResponse.self, from: data) else{
                completion(nil)
                return
            }


            let gameDetail = GameDetail(
                id: game.id ?? 0,
                name: game.name ?? "",
                released : game.released ?? "",
                backgroundImage : game.backgroundImage ?? "Unavailable!",
                backgroundImageAdditional : game.backgroundImageAdditional ?? "Unavailable!",
                rating : game.rating ?? 0.0,
                description : game.description ?? ""
                )
            
            DispatchQueue.main.async {
                completion(gameDetail)
            }
        }.resume()
    }
    
    func fetchGame(completion: @escaping ([Game]?) -> Void) {
        guard let urlLink = URL(string: "\(baseUrl)games?key=0cfaaba11cb543ee824e63a476ee4df4") else {return}
        URLSession.shared.dataTask(with: urlLink){ (data, _, _) in
            guard let data = data else{
                completion(nil)
                return
            }
            guard let game = try? JSONDecoder().decode(GameResponseList.self, from: data) else{
                completion(nil)
                return
            }
            
            var games : [Game] = []
            game.results?.forEach({ (result) in
                games.append(Game(
                    id: result.id ?? 0,
                    name: result.name ?? "",
                    released: result.released ?? "", backgroundImage: result.backgroundImage ?? "Unavailable!",
                    rating: result.rating ?? 0.0
                 
                ))
            })
            
            DispatchQueue.main.async {
                completion(games)
            }
        }.resume()
    }
}
