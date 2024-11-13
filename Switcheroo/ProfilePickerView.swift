//
//  ProfilePickerView.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import SwiftUI


struct ProfilePickerView: View {

    let urlToOpen: String

    @State private var profiles = UserDefaults.standard.dictionary(forKey: "profiles") as? [String: String] ?? [:]

    var body: some View {
        Text("Profile picker:")

        ForEach(profiles.sorted(by: <), id: \.key) { name, identifier in
            Button("Open in \(name)") {
                openURL(urlToOpen, inWindowWithIdentifier: identifier)
            }
        }
    }

    private func openURL(_ url: String, inWindowWithIdentifier identifier: String) {
        let appleScript = """
        tell application "Safari"
            set tabExists to false
            set windowCount to count windows
            repeat with x from 1 to windowCount
                set firstTabURL to URL of tab 1 of window x
                if firstTabURL starts with "\(identifier)" then
                    set tabExists to true
                    tell window x
                        make new tab with properties {URL:"\(url)"}
                        set current tab to the last tab
                        activate
                    end tell
                    exit repeat
                end if
            end repeat
            if not tabExists then
                make new document with properties {URL:"\(url)"}
                activate
            end if
        end tell
        """

        if let scriptObject = NSAppleScript(source: appleScript) {
            DispatchQueue.global().async {
                var errorDict: NSDictionary? = nil
                scriptObject.executeAndReturnError(&errorDict)
                if let error = errorDict {
                    print("Error: \(error)")
                }
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
