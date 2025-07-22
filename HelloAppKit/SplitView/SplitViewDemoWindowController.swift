//
//  SplitViewDemoWindowController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 5/3/25.
//

import Cocoa

class SplitViewDemoWindowController: NSWindowController {

    init() {
        // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
        let window = NSWindow(
            contentRect: .zero,

            // .fullSizeContentView 중요하다.
            // 이거 빠지면 Sidebar ToolbarItem 이 구식이 된다.

            styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        super.init(window: window)

        window.title = "SplitViewWindow Demo"
        window.minSize = NSSize(width: 600, height: 400)
        window.contentViewController = SplitViewDemoController()
        setupToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupToolbar() {
        guard let window  else { fatalError() }

        let toolbar = NSToolbar(identifier: "DemoToolbar")
        toolbar.delegate = self
        toolbar.displayMode = .iconOnly

        window.toolbar = toolbar
        window.toolbarStyle = .unified
    }

    @objc func toolbarAction(_ sender: Any) {
        if  let toolbarItem = sender as? NSToolbarItem {
            print("Clicked \(toolbarItem.itemIdentifier.rawValue)")
        }
    }
}

extension NSToolbarItem.Identifier {
    static let toolbarSearchItem = NSToolbarItem.Identifier("ToolbarSearchItem")
    static let toolbarDemoTitle = NSToolbarItem.Identifier("ToolbarDemo")
}

extension SplitViewDemoWindowController: NSToolbarDelegate {

    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {

        //        if itemIdentifier == .showFonts {
        //            let item = NSToolbarItem(itemIdentifier: .showFonts)
        //            item.label = "Show fonts"
        //            item.image = NSImage(systemSymbolName: "textformat", accessibilityDescription: "Show fonts")
        //            return item
        //        }

        if  itemIdentifier == .toolbarSearchItem {
            //  `NSSearchToolbarItem` is macOS 11 and higher only
            let searchItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
            searchItem.resignsFirstResponderWithCancel = true
            searchItem.searchField.delegate = self
            searchItem.toolTip = "Search"
            return searchItem
        }

        return nil
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .toggleSidebar,
            .sidebarTrackingSeparator,
            .flexibleSpace,
            .showFonts,
            .toolbarSearchItem,
            .inspectorTrackingSeparator,
            .toggleInspector,
        ]
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .toggleSidebar,
            .sidebarTrackingSeparator,
            .flexibleSpace,
            .showFonts,
            .toolbarSearchItem,
            .inspectorTrackingSeparator,
            .toggleInspector,
        ]
    }

}

extension SplitViewDemoWindowController: NSSearchFieldDelegate {
}
