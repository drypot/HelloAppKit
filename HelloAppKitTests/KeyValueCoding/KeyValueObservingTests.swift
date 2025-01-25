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

    // Use @objc and dynamic to make the property observable

    class BankAccount: NSObject {
        @objc dynamic var balance: Double

        init(balance: Double) {
            self.balance = balance
        }
    }

    @Test func testObservationWithNew() throws {
        let logger = SimpleLogger<String>()

        let account = BankAccount(balance: 1000.0)

        let observation = account.observe(\.balance, options: .new) { account, change in
            if let newValue = change.newValue {
                logger.append("changed to \(newValue)")
            }
        }

        // Change the balance
        account.balance += 500.0 // This will trigger the observation
        account.balance -= 300.0 // This will also trigger the observation

        // Cleanup
        observation.invalidate()

        #expect(logger.log() == [
            "changed to 1500.0",
            "changed to 1200.0",
        ])
    }

    @Test func testObservationWithOld() throws {
        let logger = SimpleLogger<String>()

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

        #expect(logger.log() == [
            "changed from 1000.0 to 1500.0",
            "changed from 1500.0 to 1200.0",
        ])
    }

}
