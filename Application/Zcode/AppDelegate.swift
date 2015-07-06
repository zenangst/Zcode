//
//  AppDelegate.swift
//  Zcode
//
//  Created by Christoffer Winterkvist on 01/07/15.
//  Copyright (c) 2015 zenangst. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        activateOrOpenXcode()
    }

    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        activateOrOpenXcode()

        return true
    }

    func application(sender: NSApplication, openFiles filenames: [String]) {
        let task = NSTask()
        task.launchPath = "/usr/bin/osascript"
        for file in filenames {
            let appleScript = "tell application \"Xcode\"\n open \"\(file)\"\n\nend"
            task.arguments = ["-e", appleScript]
            task.launch()
        }
        activateXcode()
    }

    func activateOrOpenXcode() {
        let applications = NSWorkspace.sharedWorkspace().runningApplications
        let application = applications.filter { $0.localizedName == "Xcode" }.last

        if application != nil {
            self.activateXcode()
        } else {
            self.launchXcode()
        }
    }

    func activateXcode() {
        let task = NSTask()
        task.launchPath = "/usr/bin/osascript"
        task.arguments = ["-e", "tell application \"Xcode\" to activate"]
        task.launch()
    }

    func launchXcode() {
        let task = NSTask()
        task.launchPath = "/Applications/Xcode.app/Contents/MacOS/Xcode"
        task.arguments = ["</dev/null &>/dev/null &"]
        task.launch()
    }
}

