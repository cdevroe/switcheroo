//
//  SafariExtensionHandler.swift
//  Extension
//
//  Created by Zhenyi Tan on 13/7/25.
//

import SafariServices


class SafariExtensionHandler: SFSafariExtensionHandler {

    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        page.getPropertiesWithCompletionHandler { properties in
            if messageName == "switchProfile" {
                guard let url = properties?.url else { return }

                page.getContainingTab { tab in
                    NSWorkspace.shared.open(url)
                    tab.close()
                }
            }
        }
    }

    override func toolbarItemClicked(in window: SFSafariWindow) {
        window.getActiveTab { tab in
            guard let tab = tab else { return }

            tab.getActivePage { page in
                guard let page = page else { return }

                page.getPropertiesWithCompletionHandler { properties in
                    guard let url = properties?.url else { return }

                    NSWorkspace.shared.open(url)
                    tab.close()
                }
            }
        }
    }

}
