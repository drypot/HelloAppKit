//
//  ToolbarDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 3/9/25.
//

import Cocoa

// Adopt the new look of macOS
// https://developer.apple.com/videos/play/wwdc2020/10104

// Integrating a Toolbar and Touch Bar into Your App
// https://developer.apple.com/documentation/appkit/integrating-a-toolbar-and-touch-bar-into-your-app

// https://github.com/marioaguzman/toolbar

// macOS full height sidebar window
// https://medium.com/@bancarel.paul/macos-full-height-sidebar-window-62a214309a80

class ToolbarDemo: NSViewController {

    var windowController: ToolbarDemoWindowController?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let button1 = NSButton(title: "Open window", target: self, action: #selector(openWindow))
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func openWindow() {
        if windowController == nil {
            windowController = ToolbarDemoWindowController()
        }
        guard let windowController else {
            fatalError()
        }
        windowController.window?.center()
        windowController.showWindow(nil)
    }

}

class ToolbarDemoWindowController: NSWindowController {
    convenience init() {
        // window 는 windowController 가 retain 하므로 따로 retain 하지 않아도 된다.
        let window = NSWindow(
            contentRect: .zero,

            // .fullSizeContentView 중요하다.
            // 이거 빠지면 Sidebar ToolbarItem 이 구식이 된다.

            styleMask: [.titled, .closable, .resizable, .miniaturizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        self.init(window: window)

        window.title = "Toolbar Demo"
        window.contentViewController = ToolbarDemoViewController()
    }
}

class ToolbarDemoViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplitView()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        setupToolbar()
    }

    func setupSplitView() {
        let sidebarVC = SidebarViewController()
        let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarVC)
        // sidebarItem.allowsFullHeightLayout = true // true 가 기본 값이다.
        sidebarItem.canCollapse = true
        sidebarItem.minimumThickness = 200
        sidebarItem.maximumThickness = 250
        addSplitViewItem(sidebarItem)

        let mainVC = MainViewController()
        let mainItem = NSSplitViewItem(contentListWithViewController: mainVC)
        mainItem.minimumThickness = 400
        addSplitViewItem(mainItem)

        let inspectorVC = InspectorViewController()
        let inspectorItem = NSSplitViewItem(inspectorWithViewController: inspectorVC)
        inspectorItem.canCollapse = true
        inspectorItem.minimumThickness = 200
        inspectorItem.maximumThickness = 250
        addSplitViewItem(inspectorItem)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 900),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupToolbar() {
        guard let window = self.view.window else {
            fatalError()
        }

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

extension ToolbarDemoViewController: NSToolbarDelegate {

    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {

        // 기본 NSToolbarItem 들은 설정 안 해도 그냥 동작한다;

//        if itemIdentifier == .toggleSidebar {
//            let item = NSToolbarItem(itemIdentifier: .toggleSidebar)
//            item.label = "Sidebar"
//            item.image = NSImage(systemSymbolName: "sidebar.left", accessibilityDescription: "Toggle Sidebar")
//            item.target = self
//            item.action = #selector(toggleSidebar(_:))
//            return item
//        }

//        if itemIdentifier == .showFonts {
//            let item = NSToolbarItem(itemIdentifier: .showFonts)
//            item.label = "Show fonts"
//            item.image = NSImage(systemSymbolName: "textformat", accessibilityDescription: "Show fonts")
//            return item
//        }

        if  itemIdentifier == NSToolbarItem.Identifier.toolbarSearchItem {
            //  `NSSearchToolbarItem` is macOS 11 and higher only
            let searchItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
            searchItem.resignsFirstResponderWithCancel = true
            searchItem.searchField.delegate = self
            searchItem.toolTip = "Search"
            return searchItem
        }

//        if itemIdentifier == .toggleInspector {
//            let item = NSToolbarItem(itemIdentifier: .toggleInspector)
//            item.label = "Inspector"
//            item.image = NSImage(systemSymbolName: "sidebar.right", accessibilityDescription: "Toggle Inspector")
//            item.target = self
//            item.action = #selector(toggleInspector(_:))
//            return item
//        }

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

extension ToolbarDemoViewController: NSSearchFieldDelegate{
    
}

extension ToolbarDemoViewController {

    class MainViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.white.cgColor

            let label = NSTextField(labelWithString: "Main")
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
        }
    }

    class SidebarViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor

            let label = NSTextField(labelWithString: "SideBar")
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                //  view.topAnchor 대신 view.safeAreaLayoutGuide.topAnchor 써야 서브뷰들이 사이드바 천정에 닿지 않는다.
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
        }
    }

    class InspectorViewController: NSViewController {
        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor

            let label = NSTextField(labelWithString: "Inspector")
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
        }
    }

}
