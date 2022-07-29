//
//  CodonMasterApp.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/19.
//

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

@main
struct CodonMasterApp: App {
    
    init () {
        FirebaseApp.configure()
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        // fetch announcement
        
        remoteConfig.fetch { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            remoteConfig.activate { changed, error in
                let decoder = JSONDecoder()
                if let json = try? decoder.decode([Announcement].self, from: remoteConfig["announcement"].dataValue) {
                    print(json)
                    UserDefaults.standard.announcements = json
                }
            }
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
