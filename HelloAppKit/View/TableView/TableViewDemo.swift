//
//  TableViewController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/15/24.
//

import Cocoa

class TableViewDemo: NSViewController {

    class Person {
        var name: String
        var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let nameField = NSTextField()
    let ageField = NSTextField()
    let addButton = NSButton()

    var people = [Person]()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        // StackView 를 썼더니 NSTextField에서 다음 NSTextField로 Tab 키로 이동할 수가 없다;
        // 수작업 레이아웃해야 한다;

        setupScrollView()
        setupTable()
        setupFields()
        loadData()
    }

    private func loadData() {
        people = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 22)
        ]
        tableView.reloadData()
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
            scrollView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.usesAutomaticRowHeights = true
        tableView.selectionHighlightStyle = .regular

        tableView.dataSource = self
        tableView.delegate = self

        let nameColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("name"))
        nameColumn.title = "Name"
        nameColumn.width = 180
        tableView.addTableColumn(nameColumn)

        let ageColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("age"))
        ageColumn.title = "Age"
        ageColumn.width = 180
        tableView.addTableColumn(ageColumn)
    }

    private func setupFields() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholderString = "Enter name"
        view.addSubview(nameField)

        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.placeholderString = "Age"
        view.addSubview(ageField)

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.title = "Add"
        addButton.target = self
        addButton.action = #selector(addPerson)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameField.widthAnchor.constraint(equalToConstant: 200),

            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 8),
            ageField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            ageField.widthAnchor.constraint(equalToConstant: 200),

            addButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 8),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
    }

    @objc func addPerson() {
        let name = nameField.stringValue
        guard let age = Int(ageField.stringValue) else {
            print("Invalid age")
            return
        }

        let person = Person(name: name, age: age)
        people.append(person)
        tableView.reloadData()

        nameField.stringValue = ""
        ageField.stringValue = ""
    }

}

extension TableViewDemo: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }

}

extension TableViewDemo: NSTableViewDelegate {

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
            textField.backgroundColor = .clear // 이거 안 하면 행이 선택되었을 때 배경색이 바뀌지 않는다;

            cell.addSubview(textField)
            cell.textField = textField

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        }

        let person = people[row]

        if id.rawValue == "name" {
            cell.textField?.stringValue = person.name
        } else if id.rawValue == "age" {
            cell.textField?.stringValue = "\(person.age)"
        }

        return cell
    }
}
