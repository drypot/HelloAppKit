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
        let demos: [Demo]
    }

    static let sections = [
        DemoSection(label: "Window", demos: [
            Demo(label: "Window", controllerType: WindowDemo.self),
            Demo(label: "SheetWindow", controllerType: SheetWindowDemo.self),
            Demo(label: "PresentAsSheet", controllerType: PresentAsSheetDemo.self),
        ]),
        DemoSection(label: "View", demos: [
            Demo(label: "View", controllerType: ViewDemo.self),
            Demo(label: "CustomView", controllerType: CustomViewDemo.self),
            Demo(label: "CompositeView", controllerType: CompositeViewDemo.self),
            Demo(label: "ViewControllerStack", controllerType: ViewControllerStackDemo.self),
        ]),
        DemoSection(label: "Layout", demos: [
            Demo(label: "AutoResizing", controllerType: AutoResizingDemo.self),
            Demo(label: "AutoLayout", controllerType: AutoLayoutDemo.self),
            Demo(label: "Constrant", controllerType: ConstrantDemo.self),
            Demo(label: "StackView", controllerType: StackViewDemo.self),
            Demo(label: "ScrollView", controllerType: ScrollViewDemo.self),
        ]),
        DemoSection(label: "Controls", demos: [
            Demo(label: "TextField", controllerType: TextFieldDemo.self),
            Demo(label: "Button", controllerType: ButtonDemo.self),
            Demo(label: "ButtonBar", controllerType: ButtonBarDemo.self),
            Demo(label: "PopOver", controllerType: PopOverDemo.self),
        ]),
        DemoSection(label: "TextKit", demos: [
            Demo(label: "TextView TextKit2", controllerType: TextViewTextKit2Demo.self),
            Demo(label: "TextView TextKit1 ", controllerType: TextViewTextKit1Demo.self),
            Demo(label: "TextView NoWarp", controllerType: TextViewNoWrapDemo.self),
            Demo(label: "TextView NoScroller", controllerType: TextViewNoScrollerDemo.self),
            Demo(label: "Draw AttrString", controllerType: DrawAttrStringDemo.self),
            Demo(label: "Draw TextKit1", controllerType: DrawTextKit1Demo.self),
            Demo(label: "Draw TextKit2", controllerType: DrawTextKit2Demo.self),
            Demo(label: "NSAttributedString", controllerType: NSAttributedStringDemo.self),
            Demo(label: "Attributed String", controllerType: AttributedStringDemo.self),
        ]),
        DemoSection(label: "Table", demos: [
            Demo(label: "TableView", controllerType: TableViewDemo.self),
            Demo(label: "TableViewCocoaBinding", controllerType: TableViewCocoaBindingDemo.self),
        ]),
        DemoSection(label: "SplitView", demos: [
            Demo(label: "SplitView", controllerType: SplitViewDemo.self),
            Demo(label: "SplitViewSimple", controllerType: SplitViewSimpleDemo.self),
        ]),
        DemoSection(label: "Color", demos: [
            Demo(label: "UIColor", controllerType: UIColorDemo.self),
            Demo(label: "SystemColor", controllerType: SystemColorDemo.self),
        ]),
        DemoSection(label: "Material", demos: [
            Demo(label: "Material", controllerType: MaterialDemo.self),
        ]),
        DemoSection(label: "Symbol", demos: [
            Demo(label: "Symbol", controllerType: SymbolDemo.self),
        ]),

        DemoSection(label: "Gesture", demos: [
            Demo(label: "GestureRecognizer", controllerType: GestureRecognizerDemo.self),
        ]),
        DemoSection(label: "CocoaBinding", demos: [
            Demo(label: "CocoaBinding", controllerType: CocoaBindingDemo.self),
            Demo(label: "TargetAction", controllerType: TargetActionDemo.self),
            Demo(label: "KeyValueBinding", controllerType: KeyValueBindingDemo.self),
            Demo(label: "NSEditor", controllerType: NSEditorDemo.self),
        ]),
//        DemoSection(label: "Graphics", demos: [
//            Demo(label: "GraphicButton", controllerType: GraphicButtonDemo.self),
//            Demo(label: "DialClock", controllerType: DialClockController.self),
//            Demo(label: "PieClock", controllerType: PieClockController.self),
//            //            Demo(label: "DialClock", controllerType: AddStackDemo.self),
//            //            Demo(label: "GraphicButton", controllerType: EasyStackControllerDemo.self),
//            //            Demo(label: "PieClock", controllerType: EasyStackControllerDemo.self),
//        ]),
//        DemoSection(label: "Animation", demos: [
//            Demo(label: "Mastering macOS 11", controllerType: AnimationDemo.self),
//        ]),
        DemoSection(label: "Document", demos: [
            Demo(label: "Document", controllerType: DocumentDemo.self),
        ]),
        DemoSection(label: "NotificationCenter", demos: [
            Demo(label: "NotificationCenter", controllerType: NotificationCenterDemo.self),
        ]),
//        DemoSection(label: "", demoList: [
//            Demo(label: "", controllerType: .self),
//            Demo(label: "", controllerType: .self),
//        ]),
//        DemoSection(label: "", demoList: [
//            Demo(label: "", controllerType: .self),
//            Demo(label: "", controllerType: .self),
//        ]),
        DemoSection(label: "Utility", demos: [
            Demo(label: "SubRunner", controllerType: SubRunnerDemo.self),
        ]),

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
            splitViewItem.canCollapse = false
            addSplitViewItem(splitViewItem)
        }

        do {
            subSectionListController.navigatorController = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: subSectionListController)
            splitViewItem.canCollapse = false
            addSplitViewItem(splitViewItem)
        }

        do {
            contentController.navigatorController = self
            let splitViewItem = NSSplitViewItem(viewController: contentController)
            addSplitViewItem(splitViewItem)
        }

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
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
            let view = NSView()
            self.view = view

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
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 160),
            ])
        }

        func numberOfRows(in tableView: NSTableView) -> Int {
            return sections.count
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let id = tableColumn!.identifier
            let cell: NSTableCellView

            if let cachedCell = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
                cell = cachedCell
            } else {
                cell = NSTableCellView()
                cell.identifier = id

                let textField = NSTextField()
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear

                cell.addSubview(textField)
                cell.textField = textField

                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                    textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                    textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                ])
            }

            cell.textField!.stringValue = sections[row].label

            return cell
        }

        func tableViewSelectionDidChange(_ notification: Notification) {
            let selectedRow = tableView.selectedRow
            if selectedRow >= 0 {
                let subSectionListController = navigatorController.subSectionListController
                subSectionListController.tableView.reloadData()
                subSectionListController.tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
                UserDefaults.standard.set(selectedRow, forKey: UserDefaultKeys.sectionIndex.rawValue)
            }
        }
    }

    class SubSectionListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
        weak var navigatorController: NavigatorController!
        let tableView: NSTableView = NSTableView()

        override func loadView() {
            let view = NSView()
            self.view = view

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
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
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
            return section?.demos.count ?? 0
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            let id = tableColumn!.identifier
            let cell: NSTableCellView

            if let cachedCell = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
                cell = cachedCell
            } else {
                cell = NSTableCellView()
                cell.identifier = id

                let textField = NSTextField()
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isEditable = false
                textField.isBordered = false
                textField.backgroundColor = .clear

                cell.addSubview(textField)
                cell.textField = textField

                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                    textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                    textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                ])
            }

            guard let section else {
                return cell
            }

            let demo = section.demos[row]
            cell.textField!.stringValue = demo.label

            return cell
        }

        func tableViewSelectionDidChange(_ notification: Notification) {
            guard let section else { return }

            let selectedRow = tableView.selectedRow
            if selectedRow >= 0 && selectedRow < section.demos.count {
                let demo = section.demos[selectedRow]
                navigatorController.contentController.use(controller: demo.controllerType.init())
                UserDefaults.standard.set(selectedRow, forKey: UserDefaultKeys.subSectionIndex.rawValue)
            }
        }
    }

    class ContentController: NSViewController {
        weak var navigatorController: NavigatorController!
        var controller: NSViewController!

        override func loadView() {
            let view = NSView()
            self.view = view
        }

        func use(controller: NSViewController) {
            self.controller = controller
            let subview = controller.view
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.subviews = [subview]

            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: view.topAnchor),
                subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                subview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
}
