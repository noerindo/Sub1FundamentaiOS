//
//  ErrorView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct ErrorView: View {
    var text : String
    var body: some View {
        VStack{
            Image(systemName: "nosign")
                .resizable()
                .frame(width: 350, height: 350.0)
                .foregroundColor(.blue)
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 0))
            
            Text("No \(text) Data or Error")
                .foregroundColor(.blue)
                .lineLimit(2)
                .font(Font.system(size:26 , weight: .heavy))
                .padding(.top,16)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(text:"Games")
    }
}
