//
//  CodonMasterApp.swift
//  CodonMaster
//
//  Created by 양현서 on 2022/07/19.
//

import SwiftUI
import FirebaseCore

@main
struct CodonMasterApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
