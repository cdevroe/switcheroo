//
//  SettingsView.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 13/11/24.
//

import SwiftUI


struct SettingsView: View {

    @State private var profiles = UserDefaults.standard.dictionary(forKey: "profiles") as? [String: String] ?? [:]
    @State private var newName = ""
    @State private var newIdentifier = ""

    var body: some View {
        ForEach(profiles.sorted(by: <), id: \.key) { name, identifier in
            HStack {
                Text("\(name): \(identifier)")
                    .lineLimit(1)

                Spacer()

                Button {
                    deleteProfile(name)
                } label: {
                    Image(systemName: "trash")
                }
            }
        }

        addProfileView
    }

    private var addProfileView: some View {
        HStack {
            TextField("Profile", text: $newName)
            TextField("URL", text: $newIdentifier)

            Button {
                addProfile()
            } label: {
                Image(systemName: "plus")
            }
        }
    }

    private func addProfile() {
        guard !newName.isEmpty, !newIdentifier.isEmpty else { return }
        profiles[newName] = newIdentifier
        UserDefaults.standard.set(profiles, forKey: "profiles")
        newName = ""
        newIdentifier = ""
    }

    private func deleteProfile(_ name: String) {
        profiles[name] = nil
        UserDefaults.standard.set(profiles, forKey: "profiles")
    }

}
