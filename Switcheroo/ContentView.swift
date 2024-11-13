//
//  ContentView.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 7/3/24.
//

import SwiftUI


struct ContentView: View {

    @State private var urlToOpen = ""

    var body: some View {
        Group {
            if !urlToOpen.isEmpty {
                ProfilePickerView(urlToOpen: urlToOpen)
            } else {
                SettingsView()
            }
        }
        .padding()
        .onOpenURL { url in
            urlToOpen = url.absoluteString
        }
    }

}
