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

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let addButton = NSButton()

    var items = [Person]()

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupTable()
        setupFields()
        loadData()
    }

    private func loadData() {
        items = [
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
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.title = "Add New"
        addButton.target = self
        addButton.action = #selector(addItem)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
    }

    @objc func addItem() {
        let person = Person(name: "New", age: 20)
        items.append(person)
        tableView.reloadData()

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
        let cell: NSTableCellView

        if let cachedCell = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
            cell = cachedCell
        } else {
            cell = NSTableCellView()
            cell.identifier = id

            let textField = NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isEditable = true
            textField.isBordered = false
            textField.drawsBackground = false
            textField.delegate = self
//            textField.tag = row

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
        guard row >= 0, column >= 0 else { return }

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
                    nextRow = 0
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

        DispatchQueue.main.async {
            self.tableView.selectRowIndexes(IndexSet(integer: nextRow), byExtendingSelection: false)
            self.tableView.editColumn(nextColumn, row: nextRow, with: nil, select: true)
        }

    }

    func printItems() {
        print("---")
        for item in items {
            print("\(item.name), \(item.age)")
        }
    }

}
