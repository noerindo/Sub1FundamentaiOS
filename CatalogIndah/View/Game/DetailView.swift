//
//  DetailView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct DetailView: View {
    @State var isSaved = true
    var gameId : String
    var backgroundImage : String
    var isImageAvailable : Bool
    @ObservedObject var gameDetailViewModel = GameDetailViewModel()
    @ObservedObject var remoteImage : RemoteImage = RemoteImage()
    init(gameId : String, backgroundImage : String) {
        self.gameId = gameId
        self.backgroundImage = backgroundImage
        isImageAvailable = backgroundImage == "Unavailable!" ? false : true
    }
    
    var body: some View {
        VStack(alignment: .center){
            if gameDetailViewModel.loading {
                VStack(alignment: .center){
                    LoadingView(color: Color.blue, size: 50)
                }
            }else{
                List{
                    VStack(alignment: .leading){
                        if isImageAvailable {
                            if remoteImage.loadDone {
                                if remoteImage.isValid {
                                    Image(uiImage: remoteImage.imageFromRemote())
                                        .resizable()
                                        .frame(height: 250.0)
                                }
                            }
                        }
                        VStack{
                            Text(gameDetailViewModel.gameDetail.name)
                                .font(Font.system(size:24))
                                .foregroundColor(.blue)
                                .bold()
                                .lineLimit(2)
                                .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                            
                            HStack{
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 24.0, height: 24.0)
                                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 0))
                                Text("\(gameDetailViewModel.gameDetail.released)")
                                    .font(Font.system(size:16))
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 4))
                                
                                Text("⭐️")
                                    .frame(width: 24.0, height: 24.0)
                                    .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 0))
                                Text("\(gameDetailViewModel.gameDetail.rating.format())")
                                    .font(Font.system(size:16))
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 4))

                            }.padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                        }
                        
                        VStack(alignment: .leading){

                            Text("\(gameDetailViewModel.gameDetail.description.replacingOccurrences(of: "\r\n", with:"" ))")
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size:18))
                                .frame(minWidth: 0, maxWidth: .infinity,  alignment: .center)
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                        }
                    }
                }
                .padding(.leading, -20)
                .padding(.trailing, -20)
                
            }
        }.onAppear {
            self.gameDetailViewModel.loadGameDataById(id: self.gameId)
            self.remoteImage.setUrl(urlString: self.backgroundImage)
            if self.isImageAvailable{
                self.remoteImage.getRemoteImage()
            }
            
        }
              
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(gameId: "4398",backgroundImage: "")
    }
}
