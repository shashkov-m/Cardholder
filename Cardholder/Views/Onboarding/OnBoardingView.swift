//
//  OnBoardingView.swift
//  Cardholder
//
//  Created by Max Shashkov on 06.08.2022.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var isHidden = true
    let text = NSLocalizedString("onBoardingDescription", comment: "")
    var body: some View {
        VStack {
            if !isHidden {
                Spacer()
                Text(.welcome)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text(.init(text))
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .padding()
                
                Spacer()
                Button {
                    UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                    Analytics.shared.agreedWithOnboarding()
                } label: {
                    RoundedButtonView(width: 300, text: NSLocalizedString("continueButton", comment: ""))
                }
            }
        }
        .transition(.opacity)
        .onAppear {
            withAnimation(.linear(duration: 1)) {
                isHidden = false
            }
        }
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
