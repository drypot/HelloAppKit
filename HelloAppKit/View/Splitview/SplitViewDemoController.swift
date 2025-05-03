//
//  SplitViewDemoController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 5/3/25.
//

import Cocoa

class SplitViewDemoController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sidebarController = SplitViewDemoSidebarController()
        let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarController)
        sidebarItem.canCollapse = true
        sidebarItem.minimumThickness = 200
        sidebarItem.maximumThickness = 250
        addSplitViewItem(sidebarItem)

        let mainController = SplitViewDemoMainController()
        let mainItem = NSSplitViewItem(contentListWithViewController: mainController)
        mainItem.minimumThickness = 400
        addSplitViewItem(mainItem)

        let inspectorController = SplitViewDemoInspectorController()
        let inspectorItem = NSSplitViewItem(inspectorWithViewController: inspectorController)
        inspectorItem.canCollapse = true
        inspectorItem.minimumThickness = 200
        inspectorItem.maximumThickness = 250
        addSplitViewItem(inspectorItem)
    }

}
