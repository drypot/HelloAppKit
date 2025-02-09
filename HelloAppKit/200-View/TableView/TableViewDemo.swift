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

    let padding = 20.0
    let interPadding = 8.0

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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
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

        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: interPadding),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            nameField.widthAnchor.constraint(equalToConstant: 200),
        ])

        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.placeholderString = "Age"
        view.addSubview(ageField)

        NSLayoutConstraint.activate([
            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: interPadding),
            ageField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            ageField.widthAnchor.constraint(equalToConstant: 200),
        ])

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.title = "Add"
        addButton.target = self
        addButton.action = #selector(addPerson)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: interPadding),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
        ])
    }

    @objc func addPerson() {
        let name = nameField.stringValue
        guard let age = Int(ageField.stringValue) else { return }

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
        guard let tableColumn else { return nil }

        let id = tableColumn.identifier
        let person = people[row]

        let cellView = {
            if let cachedView = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
                return cachedView
            }

            let textField = NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isEditable = false
            textField.isBordered = false
            textField.backgroundColor = .clear // 이거 안 하면 행이 선택되었을 때 배경색이 바뀌지 않는다;

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
        }()

        if id.rawValue == "name" {
            cellView.textField?.stringValue = person.name
        } else if id.rawValue == "age" {
            cellView.textField?.stringValue = "\(person.age)"
        }

        return cellView
    }
}
