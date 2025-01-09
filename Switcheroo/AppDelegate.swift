//
//  AppDelegate.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {

    private var url: URL?

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
        let panel = FloatingPanel(
            view: ProfilePickerView(url: url)
        )

        panel.center()
        panel.orderFront(nil)
        panel.makeKey()
    }

    private func showSettings() {
        let hostingView = NSHostingView(
            rootView: SettingsView()
        )

        let window = NSWindow(
            contentRect: NSRect(origin: .zero, size: hostingView.fittingSize),
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        window.title = "Switcheroo Settings"
        window.contentView = hostingView
        window.center()
        window.orderFront(nil)
        window.makeKey()
    }

}
