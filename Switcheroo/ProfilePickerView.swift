//
//  ProfilePickerView.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import SwiftUI


struct ProfilePickerView: View {

    let url: URL

    @State private var profiles = UserDefaults.standard.dictionary(forKey: "profiles") as? [String: String] ?? [:]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(profiles.sorted(by: <), id: \.key) { name, identifier in
                Button {
                    openURL(url.absoluteString, inWindowWithIdentifier: identifier)
                } label: {
                    Text(name)
                        .font(.title)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                }
                .cornerRadius(10)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
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
