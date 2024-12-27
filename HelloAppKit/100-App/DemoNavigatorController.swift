//
//  DemoNavigatorController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/27/24.
//

import AppKit

@MainActor
class DemoNavigatorController: NSSplitViewController {

    struct Demo {
        let label: String
        let controllerType: NSViewController.Type
    }

    struct DemoSection {
        let label: String
        let demoList: [Demo]
    }

    static let sections = [
        DemoSection(label: "Stack", demoList: [
            Demo(label: "AddStack", controllerType: AddStackDemoController.self),
            Demo(label: "EasyStack", controllerType: EasyStackControllerDemoController.self),
        ]),
        DemoSection(label: "Graphics", demoList: [
            Demo(label: "Graphics", controllerType: GraphicsDemoController.self),
            //            Demo(label: "DialClock", controllerType: AddStackDemoController.self),
            //            Demo(label: "GraphicButton", controllerType: EasyStackControllerDemoController.self),
            //            Demo(label: "PieClock", controllerType: EasyStackControllerDemoController.self),
        ]),
    ]

    var firstListController = FirstListController()
    var secondListController = SecondListController()
    var contentController = ContentController()

    // loadView() 를 오버라이드해도 되는 경우가 있지만
    // NSSplitViewController 의 경우 이런 저런 사전작업을 하는 것 같다.
    // loadView() 를 처음부터 만드는 대신 viewDidLoad() 를 쓰기로 한다.

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            firstListController.parentController = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: firstListController)
            splitViewItem.titlebarSeparatorStyle = .line
            addSplitViewItem(splitViewItem)
        }

        do {
            secondListController.parentController = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: secondListController)
            splitViewItem.titlebarSeparatorStyle = .line
            addSplitViewItem(splitViewItem)
        }

        do {
            contentController.parentController = self
            let splitViewItem = NSSplitViewItem(viewController: contentController)
            addSplitViewItem(splitViewItem)
        }

        firstListController.tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
    }

    @MainActor
    class FirstListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        weak var parentController: DemoNavigatorController!
        let tableView: NSTableView = NSTableView()

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.headerView = nil // Hide the header if not needed
            tableView.delegate = self
            tableView.dataSource = self

            let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("List"))
            column.title = "Items"
            tableView.addTableColumn(column)

            let scrollView = NSScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.hasVerticalScroller = true
            scrollView.borderType = .noBorder
            scrollView.documentView = tableView
            view.addSubview(scrollView)

            NSLayoutConstraint.activate([
                scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 160),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        func numberOfRows(in tableView: NSTableView) -> Int {
            return sections.count
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let cellIdentifier = NSUserInterfaceItemIdentifier("Cell")
            if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView {
                cell.textField!.stringValue = sections[row].label
                return cell
            }

            let cell = NSTableCellView()
            cell.identifier = cellIdentifier
            let textField = NSTextField(labelWithString: sections[row].label)
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(textField)
            cell.textField = textField

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])

            return cell
        }

        func tableViewSelectionDidChange(_ notification: Notification) {
            let selectedRow = tableView.selectedRow
            if selectedRow >= 0 {
                parentController.secondListController.tableView.reloadData()
            }
        }
    }

    class SecondListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        weak var parentController: DemoNavigatorController!
        let tableView: NSTableView = NSTableView()

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false

            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.headerView = nil // Hide the header if not needed
            tableView.delegate = self
            tableView.dataSource = self

            let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("List"))
            column.title = "Items"
            tableView.addTableColumn(column)

            let scrollView = NSScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.hasVerticalScroller = true
            scrollView.borderType = .noBorder
            scrollView.documentView = tableView
            view.addSubview(scrollView)

            NSLayoutConstraint.activate([
                scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 160),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        var section: DemoSection? {
            let selectedRow = parentController.firstListController.tableView.selectedRow
            if selectedRow >= 0 {
                return sections[selectedRow]
            }
            return nil
        }

        func numberOfRows(in tableView: NSTableView) -> Int {
            return section?.demoList.count ?? 0
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            guard let section else { return nil }
            let demo = section.demoList[row]

            let cellIdentifier = NSUserInterfaceItemIdentifier("Cell")
            if let cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView {
                cell.textField!.stringValue = demo.label
                return cell
            }

            let cell = NSTableCellView()
            cell.identifier = cellIdentifier
            let textField = NSTextField(labelWithString: demo.label)
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(textField)
            cell.textField = textField

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])

            return cell
        }

        func tableViewSelectionDidChange(_ notification: Notification) {
            guard let section else { return }

            let selectedRow = tableView.selectedRow
            if selectedRow >= 0 {
                let demo = section.demoList[selectedRow]
                parentController.contentController.use(controller: demo.controllerType.init())
            }
        }
    }

    class ContentController: NSViewController {
        weak var parentController: DemoNavigatorController!
        var controller: NSViewController!

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
//            view.wantsLayer = true
//            view.layer?.backgroundColor = NSColor.white.cgColor
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: 960),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: 800),
            ])
        }

        func use(controller: NSViewController) {
            view.subviews.forEach { $0.removeFromSuperview() }

            self.controller = controller
            controller.view.frame = view.bounds
            view.addSubview(controller.view)
        }
    }
}
