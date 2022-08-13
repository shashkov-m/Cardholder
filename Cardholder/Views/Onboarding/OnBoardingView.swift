//
//  OnBoardingView.swift
//  Cardholder
//
//  Created by Max Shashkov on 06.08.2022.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var isHidden = true
    var body: some View {
        VStack {
            if !isHidden {
            Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).")
                .padding()
                .multilineTextAlignment(.leading)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding()
                
                Spacer()
                Button {
                    UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                } label: {
                    RoundedButtonView(width: 300, text: "Got it")
                }
            }
        }
        .transition(.opacity)
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                isHidden = false
            }
        }
        .background(Image("main")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fill)
            .frame(height: UIScreen.main.bounds.height)
            .blur(radius: 1))
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
