//
//  AppDelegate.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {

    private var url: URL?
    private var settingsWindow: NSWindow?
    private var floatingPanel: NSPanel?

    func applicationDidFinishLaunching(_ notification: Notification) {
        if url == nil {
            showSettings()
        }
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        guard let url = urls.first else { return }
        self.url = url
        openPanel(with: url)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func openPanel(with url: URL) {
        floatingPanel = FloatingPanel(
            view: ProfilePickerView(url: url)
        )

        floatingPanel?.center()
        floatingPanel?.orderFront(nil)
        floatingPanel?.makeKey()
    }

    private func showSettings() {
        let hostingView = NSHostingView(
            rootView: SettingsView()
        )

        settingsWindow = NSWindow(
            contentRect: NSRect(origin: .zero, size: hostingView.fittingSize),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        settingsWindow?.title = "Switcheroo Settings"
        settingsWindow?.contentView = hostingView
        settingsWindow?.center()
        settingsWindow?.orderFront(nil)
        settingsWindow?.makeKey()
    }

}
