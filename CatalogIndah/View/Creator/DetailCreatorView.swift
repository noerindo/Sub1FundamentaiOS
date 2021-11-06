//
//  DetailCreatorView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct DetailCreatorView: View {
    var creator : Creator
    var isRemoteImageBackgroundAvailable : Bool
    var isRemoteImageCreatorAvailable : Bool
    @ObservedObject var remoteImageBackground : RemoteImage = RemoteImage()
    @ObservedObject var remoteImageCreator : RemoteImage = RemoteImage()
    
    init(creator : Creator) {
        self.creator = creator
        isRemoteImageBackgroundAvailable = creator.backgroundImage == "Unavailable!" ? false : true
        isRemoteImageCreatorAvailable = creator.image == "Unavailable!" ? false : true
    }
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                if isRemoteImageBackgroundAvailable {
                    if remoteImageBackground.loadDone {
                        if remoteImageBackground.isValid {
                            Image(uiImage: remoteImageBackground.imageFromRemote())
                                .resizable()
                                .frame(height: 250.0)
                        } else {
                            Image(systemName: "exclamtionmark.square.fill")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(height: 250.0)
                        }
                    } else {
                        LoadingView(color: Color.blue, size: 50)
                            .frame(width: UIScreen.main.bounds.size.width, height: 250.0, alignment: .center)
                    }
                } else {
                    Image(systemName: "exclamtionmark.square.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(height: 250.0)
                }
                VStack{
                    HStack{
                        if isRemoteImageCreatorAvailable {
                            if remoteImageCreator.loadDone {
                                if remoteImageCreator.isValid {
                                    Image(uiImage: remoteImageCreator.imageFromRemote())
                                        .resizable()
                                        .frame(width: 64.0, height: 64.0)
                                        .cornerRadius(10)
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 0))
                                }
                            } else {
                                LoadingView(color: Color.blue, size: 25)
                                    .frame(width: 64.0, height: 64.0)
                            }
                        }
                        
                        VStack{
                            Text(creator.name)
                                .foregroundColor(.blue)
                                .bold()
                                .lineLimit(2)
                                .font(Font.system(size:24))
                                .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 16))
                            
                        }
                    }
                }
                
                Image(systemName: "gamecontroller.fill")
                    .foregroundColor(.blue)
                    .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))

                ForEach(creator.games) { tag in
                    VStack(spacing: 10){
                        Text("\(tag.name)")
                            .bold()
                            .font(Font.system(size:16))
                            .lineLimit(nil)
                            .padding(4)
                    } .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                }
            }
            .onAppear(){
                self.remoteImageBackground.setUrl(urlString: creator.backgroundImage)
                if self.isRemoteImageBackgroundAvailable{
                    self.remoteImageBackground.getRemoteImage()
                }
                self.remoteImageCreator.setUrl(urlString: creator.image)
                if self.isRemoteImageCreatorAvailable{
                    self.remoteImageCreator.getRemoteImage()
                }
            }
        }
        .navigationBarTitle(Text(creator.name),displayMode: .inline)
    }
}

