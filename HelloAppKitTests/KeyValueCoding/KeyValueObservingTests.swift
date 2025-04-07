//
//  KeyValueObservingTests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 1/26/25.
//

import Foundation
import Testing

// https://developer.apple.com/documentation/foundation/nskeyvalueobservedchange

// https://www.cocoawithlove.com/blog/key-value-observing-wrapper.html

struct KeyValueObservingTests {

    @Test func testObserve() throws {
        let logger = SimpleLogger<String>()

        // Use @objc and dynamic to make the property observable

        class BankAccount: NSObject {
            @objc dynamic var balance: Double

            init(balance: Double) {
                self.balance = balance
            }
        }

        let account = BankAccount(balance: 1000.0)

        let observation = account.observe(\.balance, options: [.old, .new]) { account, change in
            if let oldValue = change.oldValue, let newValue = change.newValue {
                logger.append("changed from \(oldValue) to \(newValue)")
            }
        }

        // Change the balance
        account.balance += 500.0 // This will trigger the observation
        account.balance -= 300.0 // This will also trigger the observation

        // Cleanup
        observation.invalidate()

        #expect(logger.result() == [
            "changed from 1000.0 to 1500.0",
            "changed from 1500.0 to 1200.0",
        ])
    }

    @Test func testParentChild() throws {

        class Parent: NSObject, @unchecked Sendable {
            @objc dynamic var name: String

            init(name: String) {
                self.name = name
            }
        }

        class Child: NSObject, @unchecked Sendable {
            @objc dynamic var parentName: String = ""
            private var observer: NSKeyValueObservation?

            init(parent: Parent) {
                super.init()
                parentName = parent.name

                // Bind child's name to parent's name
                observer = parent.observe(\.name, options: [.new]) { [weak self] _, change in
                    if let newName = change.newValue {
                        self?.parentName = newName
                    }
                }
            }

            deinit {
                observer?.invalidate()
            }
        }

        let parent = Parent(name: "Alice")
        let child = Child(parent: parent)

        #expect(child.parentName == "Alice")

        parent.name = "Bob"

        #expect(child.parentName == "Bob")
    }
    
}
