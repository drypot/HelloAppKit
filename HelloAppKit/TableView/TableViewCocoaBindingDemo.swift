//
//  TableViewCocoaBindingDemo.swift
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

// 2025-02-09 아침 7시.
// IB를 쓰지 않고 NSTableView를 Cocoa Binding으로 채우는 시나리오는 애플 공식 문서가 없다.
// 인터넷에 다른 공개된 문서도 단서가 없다.
// GPT 가 만들어준 코드는 동작을 하지 않는다.
// 먼가 되더라고 DataSource를 쓰는 방법보다 복잡할 것 같다.
// 그리고 DataSource를 쓰는 방법이 있는데 굳이 Cocoa Binding으로 용쓸 필요도 없을 것 같다.
// 해서 이 삽질은 그만 두기로 한다.
// 애초에 내가 이걸 왜 시작했을까;
// 밤새 해봤는데 그만 두기로 한다.

// 2025-02-09 밤 11시.
// 다시 한번 도전해서 성공.

class TableViewCocoaBindingDemo: NSViewController {

    class Person: NSObject {
        @objc dynamic var name: String
        @objc dynamic var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    let arrayController = NSArrayController()
    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let nameField = NSTextField()
    let ageField = NSTextField()
    let addButton = NSButton()
    let removeButton = NSButton()

    @objc private var people: [Person] = [] {
        didSet {
            arrayController.content = people
        }
    }

    override func loadView() {
        let view = NSView()
        self.view = view

        setupTable()
        setupScrollView()
        setupFields()
        loadSampleData()
    }

    private func loadSampleData() {
        people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 22)
        ]
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.usesAutomaticRowHeights = true

        //        tableView.dataSource = self
        tableView.delegate = self

        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("name"))
        nameColumn.title = "Name"
        nameColumn.width = 180
        tableView.addTableColumn(nameColumn)

        let ageColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("age"))
        ageColumn.title = "Age"
        ageColumn.width = 100
        tableView.addTableColumn(ageColumn)

        arrayController.bind(.contentArray, to: self, withKeyPath: "people", options: nil)
        //arrayController.bind(.selectionIndexes, to: tableView, withKeyPath: "selectedRowIndexes", options: nil)

        tableView.bind(.content, to: arrayController, withKeyPath: "arrangedObjects", options: nil)
        tableView.bind(.selectionIndexes, to: arrayController, withKeyPath: "selectionIndexes", options: nil)
        tableView.bind(.sortDescriptors, to: arrayController, withKeyPath: "sortDescriptors", options: nil)

        //        nameColumn.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.name", options: nil)
        //        ageColumn.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.age", options: nil)

        //        for column in tableView.tableColumns {
        //            let keyPath = column.identifier.rawValue
        //            column.bind(.value, to: arrayController, withKeyPath: "arrangedObjects.\(keyPath)", options: nil)
        //        }

    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            scrollView.widthAnchor.constraint(equalToConstant: 400),
            scrollView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }

    private func setupFields() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.isEditable = true
        view.addSubview(nameField)

        nameField.bind(.value, to: arrayController, withKeyPath: "selection.name", options: nil)

        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.isEditable = true
        view.addSubview(ageField)

        ageField.bind(.value, to: arrayController, withKeyPath: "selection.age", options: nil)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.title = "Add"
        addButton.target = self
        addButton.action = #selector(addPerson)
        view.addSubview(addButton)

        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.title = "Remove"
        removeButton.target = self
        removeButton.action = #selector(removePerson)
        view.addSubview(removeButton)

        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameField.widthAnchor.constraint(equalToConstant: 200),

            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            ageField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            ageField.widthAnchor.constraint(equalToConstant: 200),

            addButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 8),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),

            removeButton.topAnchor.constraint(equalTo: addButton.topAnchor),
            removeButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 8),
        ])

    }

    @objc private func addPerson() {
        let newPerson = Person(name: "New Person", age: Int.random(in: 20...40))
        arrayController.addObject(newPerson)
    }

    @objc private func removePerson() {
        arrayController.remove(self)
    }

}

extension TableViewCocoaBindingDemo: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = tableColumn!.identifier
        var cell: NSTableCellView

        if let cached = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
            cell = cached
        } else {
            cell = NSTableCellView()
            cell.identifier = id

            let textField = NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isEditable = false
            textField.isBordered = false
            textField.backgroundColor = .clear // 이거 안 하면 행이 선택되었을 때 배경색이 바뀌지 않는다;

            cell.addSubview(textField)
            cell.textField = textField

            // NSTableView 에 NSArrayController 연결하는 거 이틀 삽질했는데
            // 아래 바인딩 코드가 핵심이었다.
            textField.bind(.value, to: cell, withKeyPath: "objectValue.\(id.rawValue)", options: nil)

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        }

        return cell
    }
}
