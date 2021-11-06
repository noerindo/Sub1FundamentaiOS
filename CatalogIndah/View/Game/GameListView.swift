//
//  GameListView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct GameListView: View {
     @ObservedObject var gameViewModel =  GameListViewModel()
    var body: some View {
        VStack(alignment: .center) {
            if gameViewModel.loading {
                LoadingView(color: Color.blue, size: 50)
            } else {
                if (!gameViewModel.games.results.isEmpty) {
                    List(gameViewModel.games.results) { game in
                        NavigationLink(destination: DetailView(gameId: "\(game.id)",backgroundImage: "\(game.backgroundImage)")){
                            GameRow(game: game)
                        }
                    }
                } else {
                    ErrorView(text: "Games")
                }
            }
        }
        .onAppear {
            if !(!self.gameViewModel.games.results.isEmpty) {
                self.gameViewModel.loadGameData()
                            }
        }
    }
}


struct GameRow: View {
    var game : Game
    var isImageAvailable : Bool
    @ObservedObject var remoteImage : RemoteImage = RemoteImage()
    
    init(game : Game) {
        self.game = game
        isImageAvailable = game.backgroundImage == "Unavailable!" ? false : true
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if isImageAvailable {
                if remoteImage.loadDone {
                    if remoteImage.isValid {
                        Image(uiImage: remoteImage.imageFromRemote())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 120).cornerRadius(10)
                    }
                } else {
                    LoadingView(color: Color.blue, size: 25)
                        .frame(width: 100, height: 120)
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(game.name)
                        .foregroundColor(.blue)
                        .lineLimit(2)
                        .font(Font.system(size:18))
                        .padding(.bottom,5)
                    
                }
                HStack(alignment: .center) {
                    Text("⭐️")
                        .frame(width: 20.0, height: 20.0)
                    Text(game.rating.format())
                    
                    Image(systemName: "calendar")
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(game.released)
                    

                }
            }
        }
        .cornerRadius(10)
        .frame(height: 130)
        .onAppear(){
            self.remoteImage.setUrl(urlString: game.backgroundImage)
            if self.isImageAvailable{
                self.remoteImage.getRemoteImage()
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
    }
}

