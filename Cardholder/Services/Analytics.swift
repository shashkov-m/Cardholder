//
//  Analytics.swift
//  Cardholder
//
//  Created by Max Shashkov on 23.08.2022.
//

import Foundation
import Firebase

final class Analytics {
    typealias firebaseAnalytics = Firebase.Analytics
    static let shared = Analytics()
    private let analyticsQueue = DispatchQueue(label: "analyticsQueue", qos: .utility, attributes: .concurrent)
    
    func appOpen() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent(AnalyticsEventAppOpen, parameters: nil)
        }
    }
    
    func cardSaved(imageName: String) {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("card_saved", parameters: ["backgroundImage": imageName])
        }
    }
    
    func cardDetailOpened() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("card_detail_open", parameters: nil)
        }
    }
}
