//
//  CardholderApp.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI
import PartialSheet
import FirebaseCore

@main
struct CardholderApp: App {
//    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    
    init() {
        FirebaseApp.configure()
        Analytics.shared.appOpen()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreenView()
//                .fullScreenCover(isPresented: $isFirstLaunch) {
//                    OnBoardingView()
//                }
                .attachPartialSheetToRoot()
        }
    }
}
