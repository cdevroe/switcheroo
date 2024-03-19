//
//  ContentView.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 7/3/24.
//

import SwiftUI


struct ContentView: View {

    @State private var profiles = UserDefaults.standard.dictionary(forKey: "profiles") as? [String: String] ?? [:]
    @State private var urlToOpen = ""
    @State private var openingURL = false
    @State private var newName = ""
    @State private var newIdentifier = ""

    var body: some View {
        Group {
            if openingURL {
                VStack {
                    Text("Profile picker:")
                    ForEach(profiles.sorted(by: <), id: \.key) { name, identifier in
                        Button("Open in \(name)") {
                            openURL(urlToOpen, inWindowWithIidentifier: identifier)
                        }
                    }
                }
            } else {
                VStack {
                    ForEach(profiles.sorted(by: <), id: \.key) { name, identifier in
                        HStack {
                            Text("\(name): \(identifier)")
                                .lineLimit(1)
                            Spacer()
                            Button(action: {
                                profiles[name] = nil
                                UserDefaults.standard.set(profiles, forKey: "profiles")
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                    }

                    HStack {
                        TextField("Profile", text: $newName)
                        TextField("URL", text: $newIdentifier)

                        Button(action: {
                            guard !newName.isEmpty, !newIdentifier.isEmpty else { return }
                            profiles[newName] = newIdentifier
                            UserDefaults.standard.set(profiles, forKey: "profiles")
                            newName = ""
                            newIdentifier = ""
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .padding()
        .onOpenURL { url in
            urlToOpen = url.absoluteString
            openingURL = true
        }
    }

    private func openURL(_ url: String, inWindowWithIidentifier identifier: String) {
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
