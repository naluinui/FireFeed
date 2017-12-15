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
        loadDefaultValues()
        fetchRemoteValues()
    }
    
    func loadDefaultValues() {}
    
    func fetchRemoteValues() {
        let fetchDuration: TimeInterval = 60
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
