//
//  EmptyMainView.swift
//  Cardholder
//
//  Created by Max Shashkov on 14.08.2022.
//

import SwiftUI

struct EmptyMainView: View {
    var body: some View {
        VStack {
        Text("empltyScreenTitle")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Image("arrow")
                .resizable()
                .frame(width: 200, height: 200)
        }
    }
}

struct EmptyMainView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyMainView()
    }
}
