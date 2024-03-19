//
//  SwitcherooApp.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 7/3/24.
//

import SwiftUI


@main
struct SwitcherooApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 320)
        }
        .windowResizabilityContentSize()
    }

}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
