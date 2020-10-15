//
//  AppDelegate.swift
//  FreeSpaceBar
//
//  Created by David Messem on 2020/07/22.
//  Copyright © 2020 David Messem. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusBarItem: NSStatusItem!
    var timer: Timer!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "..."
        
        let statusBarMenu = NSMenu(title: "Menu")
        statusBarItem.menu = statusBarMenu
        
        statusBarMenu.addItem(
            withTitle: "Refresh",
            action: #selector(AppDelegate.refresh),
            keyEquivalent: "")
        
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
        
        refresh()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        timer.invalidate()
    }
    
    @objc func refresh() {
        print("Ordering a burrito!")
        let url = URL.init(fileURLWithPath: "/Volumes/Macintosh HD")
        do {
            let theVolSizeAvail = try url.resourceValues(forKeys: [.volumeSupportsVolumeSizesKey])
            if let theVolSizeIsAvail = theVolSizeAvail.volumeSupportsVolumeSizes {
                if theVolSizeIsAvail {
                    let result = try url.resourceValues(forKeys: [.volumeAvailableCapacityKey, .volumeTotalCapacityKey, .volumeAvailableCapacityForImportantUsageKey, .volumeAvailableCapacityForOpportunisticUsageKey])
                    if let freeBytes = result.volumeAvailableCapacityForImportantUsage {
                        print("Free space on \(url.path) is \(freeBytes/1000000000) GB")
                        statusBarItem.button?.title = "\(freeBytes/1000000000) GB"
                    }
                }
            }
        } catch {
            print("Bad")
        }
    }
    
        
    
}

