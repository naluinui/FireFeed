//
//  RemoteConfig.swift
//  FireFeed
//
//  Created by Somjintana K. on 14/12/2017.
//  Copyright © 2017 Nui.swift. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case ratingTitleText
    case ratingMessageText
}

class RemoteConfigValue {
    
    static var shared = RemoteConfigValue()

    init() {
        RemoteConfig.remoteConfig().configSettings = RemoteConfigSettings(developerModeEnabled: true)!

        loadDefaultValues()
        fetchRemoteValues()
    }
    
    func loadDefaultValues() {
        
        let defaultValues: [String: Any?] = [
            RemoteConfigKey.ratingTitleText.rawValue: "Rate this app",
            RemoteConfigKey.ratingMessageText.rawValue: "Please take a moment to rate it"
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues as? [String: NSObject])
    }
    
    func fetchRemoteValues() {
        let fetchDuration: TimeInterval = 15
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: fetchDuration) { (_, error) in
            if error == nil {
                print("fetch complete!")
                RemoteConfig.remoteConfig().activateFetched()
            } else {
                print("cannot get data from the cloud")
            }
        }
    }
    
    func string(for key: RemoteConfigKey) -> String {
        return RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
    
}
