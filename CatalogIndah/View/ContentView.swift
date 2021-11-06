//
//  ContentView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationView{
            TabView {
                GameListView()
                    .tabItem {
                        Image(systemName: "gamecontroller.fill")
                        Text("Games")
                }

                CreatorView()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("Creator")
                }
                
            }.navigationBarTitle(Text("Games Catalogue"),displayMode: .inline)
            .navigationBarItems(trailing:  NavigationLink(destination: AboutView(), label: {
                Image(systemName: "person.crop.circle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 25, height: 25)
                
            }))
        }
    }
}
struct  ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
