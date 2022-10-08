//
//  Bundle+CurrentVersion.swift
//  Cardholder
//
//  Created by Max Shashkov on 08.10.2022.
//

import Foundation

extension Bundle {
    var appVersion: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var appBuild: String? {
        infoDictionary?["CFBundleVersion"] as? String
    }
}
