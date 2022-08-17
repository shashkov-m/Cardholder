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
            Text("onBoardDescription")
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
