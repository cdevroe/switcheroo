//
//  AppDelegate.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}
