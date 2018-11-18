//
//  ExtensionDelegate.swift
// graviumwallet WatchKit Extension
//
//  Created by ajv on 10/5/16.
//  Copyright © 2018 Graviumwallet Team. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        WatchDataManager.shared.setupTimer()
        WatchDataManager.shared.requestAllData()
    }

    func applicationWillResignActive() {
        WatchDataManager.shared.destroyTimer()
    }
}
