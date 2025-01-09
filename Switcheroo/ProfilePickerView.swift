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
    @State private var selectedIndex = 0

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(profiles.sorted(by: <).enumerated()), id: \.element.key) { index, profile in
                button(with: profile, index: index)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .background(
            KeyDownListener(
                selectedIndex: $selectedIndex,
                profiles: profiles.sorted(by: <),
                url: url,
                opener: { url, identifier in
                    openURL(url, inWindowWithIdentifier: identifier)
                }
            )
        )
    }

    private func button(with profile: Dictionary<String, String>.Element, index: Int) -> some View {
        Button {
            openURL(url.absoluteString, inWindowWithIdentifier: profile.value)
        } label: {
            Text(profile.key)
                .font(.title)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(selectedIndex == index ? Color(nsColor: .lightGray) : Color.clear)
                .foregroundColor(selectedIndex == index ? Color.primary : Color.secondary)
        }
        .buttonStyle(.plain)
        .containerShape(RoundedRectangle(cornerRadius: 10))
        .onHover { hover in
            if hover {
                selectedIndex = index
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
