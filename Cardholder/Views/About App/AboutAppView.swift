//
//  AboutAppView.swift
//  Cardholder
//
//  Created by Max Shashkov on 08.10.2022.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .frame(width: 42, height: 3)
                .foregroundColor(Color(uiColor: .systemGray4))
                .cornerRadius(8)
                .padding()
            Spacer()
            Text("contactMe")
                .padding()
                .multilineTextAlignment(.center)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding()
//                .onTapGesture {
//                    UIApplication.shared.open(URL(string: "shashkov.ma@icloud.com")!)
//                }
            Spacer()
            VStack {
                Text("Cardholder")
                HStack {
                    Text("appVersion")
                    Text(Bundle.main.appVersion ?? "1.0")
                }
                HStack {
                    Text("build")
                    Text(Bundle.main.appBuild ?? "1")
                }
            }
            .padding()
            .foregroundColor(.gray)
            .font(CustomFont.digits.getFont)
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
