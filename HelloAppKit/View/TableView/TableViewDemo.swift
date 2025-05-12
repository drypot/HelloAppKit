//
//  TableViewController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/15/24.
//

import Cocoa

// Move to next NSTableview Row when return key is pressed after editing
// https://stackoverflow.com/questions/52876470/move-to-next-nstableview-row-when-return-key-is-pressed-after-editing

// How to Tab to Next Row in NSTableView (View-based Solution)
// https://samwize.com/2018/11/13/how-to-tab-to-next-row-in-nstableview-view-based-solution/#google_vignette

class TableViewDemo: NSViewController {

    class Person {
        var name: String
        var age: Int

        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }

    var items = [Person]()

    let scrollView = NSScrollView()
    let tableView = NSTableView()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupTable()
        setupFields()
        updateItems()
    }

    private func updateItems() {
        items = [
            Person(name: "Alice", age: 25),
            Person(name: "Bob", age: 30),
            Person(name: "Charlie", age: 22)
        ]
        tableView.reloadData()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    private func setupTable() {
        scrollView.documentView = tableView

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.usesAutomaticRowHeights = true
        tableView.selectionHighlightStyle = .regular
        tableView.allowsMultipleSelection = true

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
        let addButton = NSButton(title: "Add Row", target: self, action: #selector(addRow))
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)

        let deleteButton = NSButton(title: "Delete Row", target: self, action: #selector(deleteSelectedRows))
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            deleteButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 8),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    override func keyDown(with event: NSEvent) {

        // specialKey 는 macOS 13, 2022 이상에서만 지원한다고 한다.
        // 구 버전을 지원하려면 keyCode 를 써야하는데 버추얼키 정의 테이블이 없어서 숫자를 외워야 한다.

        switch event.specialKey {
        case .delete:
            deleteSelectedRows()
        default:
            super.keyDown(with: event)
        }
    }

    @objc func addRow() {
        let person = Person(name: "New", age: 20)
        items.append(person)
        tableView.reloadData()
        printItems()
    }

    @objc func deleteSelectedRows() {
        let selectedRows = tableView.selectedRowIndexes
        guard !selectedRows.isEmpty else { return }

        let sortedIndexes = selectedRows.sorted(by: >)

        for index in sortedIndexes {
            items.remove(at: index)
        }

        tableView.removeRows(at: selectedRows, withAnimation: .effectFade)

        printItems()
    }
}

extension TableViewDemo: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }

}

extension TableViewDemo: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = tableColumn!.identifier
        var cell: NSTableCellView!

        cell = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView
        if cell == nil {
            cell = NSTableCellView()
            cell.identifier = id

            let textField = NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isEditable = true
            textField.isBordered = false
            textField.drawsBackground = false
            textField.delegate = self

            cell.addSubview(textField)
            cell.textField = textField

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        }

        let person = items[row]

        switch id.rawValue {
        case "name":
            cell.textField?.stringValue = person.name
        case "age":
            cell.textField?.stringValue = "\(person.age)"
        default:
            break
        }

        return cell
    }
}

extension TableViewDemo: NSTextFieldDelegate {

    func controlTextDidBeginEditing(_ notification: Notification) {
        guard let textField = notification.object as? NSTextField else { return }
        textField.drawsBackground = true
    }

    func controlTextDidEndEditing(_ notification: Notification) {
        guard let textField = notification.object as? NSTextField else { return }

        let row = tableView.row(for: textField)
        let column = tableView.column(for: textField)

        // 마지막 row 가 편집중인 상태에서 삭제될 수 있다.
        // 해서 row 의 items.count 범위를 확인해야 한다.
        guard 0..<items.count ~= row, column >= 0 else { return }

        let columnID = tableView.tableColumns[column].identifier

        // Update cell

        switch columnID.rawValue {
        case "name":
            items[row].name = textField.stringValue
        case "age":
            items[row].age = Int(textField.stringValue) ?? 20
        default:
            break
        }
        tableView.reloadData(forRowIndexes: IndexSet(integer: row), columnIndexes: IndexSet(integer: column))

        // Log

        printItems()

        // Restore color

        textField.drawsBackground = false

        // Select next cell

        guard
            let textMovementInt = notification.userInfo?["NSTextMovement"] as? Int,
            let textMovement = NSTextMovement(rawValue: textMovementInt) else { return }

        var nextRow = row
        var nextColumn = column

        switch textMovement {
        case .tab, .return:
            nextColumn += 1
            if nextColumn >= tableView.numberOfColumns {
                nextRow += 1
                nextColumn = 0
                if nextRow == items.count {
                    addRow()
                }
            }
        case .backtab:
            nextColumn -= 1
            if nextColumn < 0 {
                nextRow -= 1
                nextColumn = tableView.numberOfColumns - 1
                if nextRow < 0 {
                    nextRow = items.count - 1
                }
            }
        default:
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableView.selectRowIndexes(IndexSet(integer: nextRow), byExtendingSelection: false)
            self?.tableView.editColumn(nextColumn, row: nextRow, with: nil, select: true)
        }
    }

    func printItems() {
        print("---")
        for item in items {
            print("\(item.name), \(item.age)")
        }
    }

}
