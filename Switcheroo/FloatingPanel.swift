//
//  FloatingPanel.swift
//  Switcheroo
//
//  Created by Zhenyi Tan on 9/1/25.
//

import SwiftUI


class FloatingPanel<Content: View>: NSPanel {

    init(view: Content) {
        let hostingView = NSHostingView(rootView: view)

        super.init(
            contentRect: CGRect(origin: .zero, size: hostingView.fittingSize),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        isOpaque = false
        backgroundColor = .clear
        isFloatingPanel = true
        level = .floating
        collectionBehavior.insert(.fullScreenAuxiliary)

        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        isMovableByWindowBackground = true
        hidesOnDeactivate = true
        animationBehavior = .utilityWindow
        contentView = hostingView
    }

    override func resignMain() {
        super.resignMain()
        close()
    }

    override var canBecomeKey: Bool {
        return true
    }

    override var canBecomeMain: Bool {
        return true
    }

}
