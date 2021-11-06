//
//  CreatorView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct CreatorView: View {
    @ObservedObject var creatorViewModel =  CreatorListViewModel()
    var body: some View {
        VStack(alignment: .center) {
            if creatorViewModel.loading {
                LoadingView(color: Color.blue, size: 50)
            } else {
                if (creatorViewModel.creators.results.count > 0) {
                    List(creatorViewModel.creators.results) { creators in
                        NavigationLink(destination: DetailCreatorView(creator: creators)){
                            CreatorRowView(creator: creators)
                        }
                    }
                } else {
                    ErrorView(text: "Creator")
                }
            }
        }
        .onAppear {
            self.creatorViewModel.loadCreatorData()
        }
    }
}

struct CreatorRowView: View {
    var creator : Creator
    var isRemoteImageCreatorAvailable : Bool
    @ObservedObject var remoteImageCreator : RemoteImage = RemoteImage()
    init(creator : Creator) {
        self.creator = creator
        isRemoteImageCreatorAvailable = creator.image == "Unavailable!" ? false : true
    }
    
    var body: some View {
        HStack(alignment: .center) {
            if isRemoteImageCreatorAvailable {
                if remoteImageCreator.loadDone {
                    if remoteImageCreator.isValid {
                        Image(uiImage: remoteImageCreator.imageFromRemote())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 120).cornerRadius(10)
                    } else {
                        Image(systemName: "exclamtionmark.square.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 100, height: 120)
                            .cornerRadius(10)
                    }
                } else {
                    LoadingView(color: Color.blue, size: 25)
                        .frame(width: 100, height: 120)
                }
            } else {
                Image(systemName: "exclamtionmark.square.fill")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 100, height: 120)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(creator.name)
                    .foregroundColor(.blue)
                    .lineLimit(2)
                    .font(Font.system(size:22))
                    .padding(.top,16)
                
            }
        }
        .cornerRadius(10)
        .frame(height: 130)
        .onAppear(){
            self.remoteImageCreator.setUrl(urlString: creator.image)
            if self.isRemoteImageCreatorAvailable{
                self.remoteImageCreator.getRemoteImage()
            }
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
