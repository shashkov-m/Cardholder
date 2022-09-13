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
    
    func cardSaved(imageName: String, provider: String) {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("card_saved",
                                       parameters: ["backgroundImage": imageName,
                                                    "provider": provider])
        }
    }
    
    func cardDetailOpened() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("card_detail_open", parameters: nil)
        }
    }
    
    func dragAndDropAction() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("drag_and_drop_action", parameters: nil)
        }
    }
    
    func deleteAllData() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("delete_all_data", parameters: nil)
        }
    }
    
    func cardDataCopied(field: String) {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("card_data_copied", parameters: ["field": field])
        }
    }
    func cardsLoaded(count: Int) {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("cards_loaded", parameters: ["count": count])
        }
    }
    func agreedWithOnboarding() {
        analyticsQueue.async {
            firebaseAnalytics.logEvent("agreed_with_onboarding", parameters: nil)
        }
    }
}
