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
                Spacer()
                VStack {
                    HStack {
                        Text(.onBoardingDescription)
                        Spacer()
                    }
                    HStack {
                        Link("privacyPolicyButton", destination: URL(string: "https://bit.ly/3QudC3X")!)
                        Spacer()
                    }
                }
                .font(.body)
                .padding()
                .multilineTextAlignment(.leading)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding()
                
                Spacer()
                Button {
                    UserDefaults.standard.set(false, forKey: "isFirstLaunch")
                } label: {
                    RoundedButtonView(width: 300, text: NSLocalizedString("continue", comment: ""))
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
