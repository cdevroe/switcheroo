//
//  SwitcherooApp.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 7/3/24.
//

import SwiftUI


@main
struct SwitcherooApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Window("Switcheroo", id: "main") {
          ContentView()
                .frame(width: 320)
        }
        .windowResizability(.contentSize)
    }

}
