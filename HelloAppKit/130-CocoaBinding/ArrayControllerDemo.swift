//
//  ArrayControllerDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/8/25.
//

import Cocoa

// Table View Programming Guide for Mac
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TableView/Introduction/Introduction.html#//apple_ref/doc/uid/10000026i-CH1-SW1

// Create view based NSTableView programmatically using Bindings in Swift
// https://stackoverflow.com/questions/34583638/create-view-based-nstableview-programmatically-using-bindings-in-swift
//
// Is it possible to create a view-based NSTableView purely in code?
// https://stackoverflow.com/questions/33992756/is-it-possible-to-create-a-view-based-nstableview-purely-in-code
//
// 정확한 답변은 없었지만 일단 적어둔다.

// IB를 쓰지 않고 NSTableView를 Cocoa Binding으로 채우는 시나리오는 애플 공식 문서가 없다.
// 인터넷에 다른 공개된 문서도 단서가 없다.
// GPT 가 만들어준 코드는 동작을 하지 않는다.
// 먼가 되더라고 DataSource를 쓰는 방법보다 복잡할 것 같다.
// 그리고 DataSource를 쓰는 방법이 있는데 굳이 Cocoa Binding으로 용쓸 필요도 없을 것 같다.
// 해서 이 삽질은 그만 두기로 한다.
// 애초에 내가 이걸 왜 시작했을까;
// 밤새 해봤는데 그만 두기로 한다.
//
// 2025-02-09 아침 7시.

class ArrayControllerDemo: NSViewController {

    @objc class Person: NSObject {
        @objc dynamic var name: String
        @objc dynamic var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    let padding = 20.0
    let interPadding = 8.0

    private var arrayController = NSArrayController()
    private var scrollView = NSScrollView()
    private var tableView = NSTableView()
    private var nameField = NSTextField()
    private var ageField = NSTextField()
    private var addButton = NSButton()
    private var removeButton = NSButton()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupTable()
        setupFields()
        loadSampleData()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            scrollView.widthAnchor.constraint(equalToConstant: 400),
            scrollView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func setupTable() {

        tableView.translatesAutoresizingMaskIntoConstraints = false
        //        tableView.delegate = self
        //        tableView.headerView = nil
        tableView.usesAutomaticRowHeights = true

//        tableView.dataSource = self
        tableView.delegate = self

        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("name"))
        nameColumn.title = "Name"
        //        nameColumn.width = 180
        tableView.addTableColumn(nameColumn)

        let ageColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("age"))
        ageColumn.title = "Age"
        //        ageColumn.width = 100
        tableView.addTableColumn(ageColumn)

        arrayController.bind(.contentArray, to: self, withKeyPath: "people", options: nil)
        //        arrayController.bind(.selectionIndexes, to: tableView, withKeyPath: "selectedRowIndexes", options: nil)

        tableView.bind(.content, to: arrayController, withKeyPath: "arrangedObjects", options: nil)
        //        tableView.bind(.selectionIndexes, to: arrayController, withKeyPath: "selectionIndexes", options: nil)
        //        tableView.bind(.sortDescriptors, to: arrayController, withKeyPath: "sortDescriptors", options: nil)

        //        tableView.bind(.content, to: arrayController, withKeyPath: "arrangedObjects", options: nil)
        //        tableView.bind(.selectionIndexes, to: arrayController, withKeyPath: "selectionIndexes", options: nil)
        //        tableView.bind(.sortDescriptors, to: arrayController, withKeyPath: "sortDescriptors", options: nil)

        nameColumn.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.name", options: nil)
        ageColumn.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.age", options: nil)
        //        nameColumn.bind(.value, to: arrayController, withKeyPath: "objectValue.name", options: nil)
        //        ageColumn.bind(.value, to: arrayController, withKeyPath: "objectValue.age", options: nil)

        //        for column in tableView.tableColumns {
        //            let keyPath = column.identifier.rawValue
        //            column.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.\(keyPath)", options: nil)
        //        }

    }

    private func setupFields() {

        // Name Field (Detail)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.isEditable = false
        view.addSubview(nameField)

        nameField.bind(.value, to: arrayController, withKeyPath: "selection.name", options: nil)

        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: interPadding),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            nameField.widthAnchor.constraint(equalToConstant: 200),
        ])

        // Age Field (Detail)
        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.isEditable = false
        view.addSubview(ageField)

        ageField.bind(.value, to: arrayController, withKeyPath: "selection.age", options: nil)

        NSLayoutConstraint.activate([
            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: interPadding),
            ageField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            ageField.widthAnchor.constraint(equalToConstant: 200),
        ])

        // Add Button
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.title = "Add"
        addButton.target = self
        addButton.action = #selector(addPerson)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: interPadding),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
        ])

        // Remove Button
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.title = "Remove"
        removeButton.target = self
        removeButton.action = #selector(removePerson)
        view.addSubview(removeButton)

        NSLayoutConstraint.activate([
            removeButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            removeButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: interPadding),
        ])

    }

    @objc private var people: [Person] = [] {
        didSet {
            arrayController.content = people
        }
    }

    private func loadSampleData() {
        people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 22)
        ]
    }

    @objc private func addPerson() {
        let newPerson = Person(name: "New Person", age: Int.random(in: 20...40))
        arrayController.addObject(newPerson)
    }

    @objc private func removePerson() {
        arrayController.remove(self)
    }

}

//extension ArrayControllerDemo: NSTableViewDataSource {
//
//    func numberOfRows(in tableView: NSTableView) -> Int {
//        return people.count
//    }
//
//}

extension ArrayControllerDemo: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor column: NSTableColumn?, row: Int) -> NSView? {

        func makeCellView(withIdentifier id: NSUserInterfaceItemIdentifier) -> NSTableCellView {
            guard let cachedView = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView else {
                let textField = NSTextField()
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isEditable = false
                textField.isBordered = false
                textField.controlSize = .regular

                let cellView = NSTableCellView()
                cellView.identifier = id
                cellView.addSubview(textField)
                cellView.textField = textField

                NSLayoutConstraint.activate([
                    textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
                    textField.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
                    textField.topAnchor.constraint(equalTo: cellView.topAnchor),
                    textField.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
                ])

                return cellView
            }
            return cachedView
        }

        let id = column!.identifier
        let cellView = makeCellView(withIdentifier: id)

//        cellView.textField!.stringValue = "Hey"

        //
        //
        ////            // Create a text field for the cell
        ////            let textField = NSTextField()
        ////            textField.backgroundColor = NSColor.clearColor()
        ////            textField.translatesAutoresizingMaskIntoConstraints = false
        ////            textField.bordered = false
        ////            textField.controlSize = NSControlSize.SmallControlSize

        return cellView
    }
}
