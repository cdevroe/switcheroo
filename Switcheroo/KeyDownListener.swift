//
//  KeyDownListener.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 9/1/25.
//

import SwiftUI


struct KeyDownListener: NSViewRepresentable {

    @Binding var selectedIndex: Int
    let profiles: [Dictionary<String, String>.Element]
    let url: URL
    let opener: (String, String) -> Void

    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            context.coordinator.keyDown(with: event)
            return nil
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {

        var parent: KeyDownListener

        init(_ parent: KeyDownListener) {
            self.parent = parent
        }

        @objc func keyDown(with event: NSEvent) {
            switch event.keyCode {
            case 126: // Up arrow
                parent.selectedIndex = (parent.selectedIndex - 1 + parent.profiles.count) % parent.profiles.count

            case 125: // Down arrow
                parent.selectedIndex = (parent.selectedIndex + 1) % parent.profiles.count

            case 18...26: // 1-9
                let index = Int(event.keyCode - 18)
                if index < parent.profiles.count {
                    let profile = parent.profiles[index]
                    parent.opener(parent.url.absoluteString, profile.value)
                }

            case 36: // Enter
                let profile = parent.profiles[parent.selectedIndex]
                parent.opener(parent.url.absoluteString, profile.value)

            case 53: // Escape
                NSApplication.shared.terminate(nil)

            default:
                break
            }
        }

    }

}
