//
//  NavigatorController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/27/24.
//

import AppKit

@MainActor
class NavigatorController: NSSplitViewController {

    struct Demo {
        let label: String
        let controllerType: NSViewController.Type
    }

    struct DemoSection {
        let label: String
        let demoList: [Demo]
    }

    static let sections = [
        DemoSection(label: "Utility", demoList: [
            Demo(label: "SubRunner", controllerType: SubRunnerDemoController.self),
            Demo(label: "ConstraintBuilder", controllerType: ConstraintBuilderDemoController.self),
        ]),
        DemoSection(label: "Window", demoList: [
            Demo(label: "Window", controllerType: WindowDemoController.self),
        ]),
        DemoSection(label: "Stack", demoList: [
            Demo(label: "StackView", controllerType: StackViewDemoController.self),
            Demo(label: "EasyStackController", controllerType: EasyStackControllerDemoController.self),
        ]),
        DemoSection(label: "View", demoList: [
            Demo(label: "View", controllerType: ViewDemoController.self),
            Demo(label: "CustomView", controllerType: CustomViewDemoController.self),
            Demo(label: "CustomCompositeView", controllerType: CustomCompositeViewDemoController.self),
        ]),
        DemoSection(label: "Text", demoList: [
            Demo(label: "TextView", controllerType: TextViewDemoController.self),
            Demo(label: "CustomTextView", controllerType: CustomTextViewDemoController.self),
        ]),
        DemoSection(label: "Table", demoList: [
            Demo(label: "TableView", controllerType: TableViewDemoController.self),
        ]),
        DemoSection(label: "Gesture", demoList: [
            Demo(label: "GestureRecognizer", controllerType: GestureRecognizerDemoController.self),
        ]),
        DemoSection(label: "Graphics", demoList: [
            Demo(label: "GraphicButton", controllerType: GraphicButtonDemoController.self),
            Demo(label: "DialClock", controllerType: DialClockController.self),
            Demo(label: "PieClock", controllerType: PieClockController.self),
            //            Demo(label: "DialClock", controllerType: AddStackDemoController.self),
            //            Demo(label: "GraphicButton", controllerType: EasyStackControllerDemoController.self),
            //            Demo(label: "PieClock", controllerType: EasyStackControllerDemoController.self),
        ]),
        DemoSection(label: "Animation", demoList: [
            Demo(label: "Mastering macOS 11", controllerType: AnimationDemoController.self),
        ]),
//        DemoSection(label: "", demoList: [
//            Demo(label: "", controllerType: .self),
//            Demo(label: "", controllerType: .self),
//        ]),
//        DemoSection(label: "", demoList: [
//            Demo(label: "", controllerType: .self),
//            Demo(label: "", controllerType: .self),
//        ]),
//        DemoSection(label: "", demoList: [
//            Demo(label: "", controllerType: .self),
//            Demo(label: "", controllerType: .self),
//        ]),
    ]

    enum UserDefaultKeys: String {
        case sectionIndex
        case subSectionIndex
    }

    var sectionListController = SectionListController()
    var subSectionListController = SubSectionListController()
    var contentController = ContentController()

    // loadView() 를 오버라이드해도 되는 경우가 있지만
    // NSSplitViewController 의 경우 이런 저런 사전작업을 하는 것 같다.
    // loadView() 를 처음부터 만드는 대신 viewDidLoad() 를 쓰기로 한다.

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            sectionListController.navigatorController = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: sectionListController)
            splitViewItem.titlebarSeparatorStyle = .line
            addSplitViewItem(splitViewItem)
        }

        do {
            subSectionListController.navigatorController = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: subSectionListController)
            splitViewItem.titlebarSeparatorStyle = .line
            addSplitViewItem(splitViewItem)
        }

        do {
            contentController.navigatorController = self
            let splitViewItem = NSSplitViewItem(viewController: contentController)
            addSplitViewItem(splitViewItem)
        }
    }

    override func viewWillAppear() {
        // viewDidLoad 에서 tableView.selectRowIndexes 하면 tableViewSelectionDidChange 가 두 번 발생한다.
        // tableView.selectRowIndexes 는 가급적 viewWillAppear 에서 실행한다.
        let userDefaults = UserDefaults.standard
        let sectionIndex = userDefaults.integer(forKey: UserDefaultKeys.sectionIndex.rawValue)
        let subSectionIndex = userDefaults.integer(forKey: UserDefaultKeys.subSectionIndex.rawValue)
        sectionListController.tableView.selectRowIndexes(IndexSet(integer: sectionIndex), byExtendingSelection: false)
        subSectionListController.tableView.selectRowIndexes(IndexSet(integer: subSectionIndex), byExtendingSelection: false)
    }

    @MainActor
    class SectionListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        weak var navigatorController: NavigatorController!
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
                navigatorController.subSectionListController.tableView.reloadData()
                UserDefaults.standard.set(selectedRow, forKey: UserDefaultKeys.sectionIndex.rawValue)
            }
        }
    }

    class SubSectionListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        weak var navigatorController: NavigatorController!
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
            let selectedRow = navigatorController.sectionListController.tableView.selectedRow
            if selectedRow >= 0 && selectedRow < sections.count {
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
            if selectedRow >= 0 && selectedRow < section.demoList.count {
                let demo = section.demoList[selectedRow]
                navigatorController.contentController.use(controller: demo.controllerType.init())
                UserDefaults.standard.set(selectedRow, forKey: UserDefaultKeys.subSectionIndex.rawValue)
            }
        }
    }

    class ContentController: NSViewController {
        weak var navigatorController: NavigatorController!
        var controller: NSViewController!

        override func loadView() {
            view = NSView()
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        func use(controller: NSViewController) {
            self.controller = controller
            let subview = controller.view
            view.subviews = [subview]

            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: view.topAnchor),
                subview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
}
