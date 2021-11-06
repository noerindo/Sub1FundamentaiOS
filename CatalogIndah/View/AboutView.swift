//
//  AboutView.swift
//  CatalogIndah
//
//  Created by Indah Nurindo on 31/08/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            VStack {
                Image("indah")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    .shadow(radius: 10)
                Text("Indah Nurindo")
                    .fontWeight(.bold)
                    .font(.system(size: 40))
                    .foregroundColor(.black)
                Text("Kepulauan Riau, karimun")
                    .font(.system(size: 20))
            }
        }
    .navigationBarTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

