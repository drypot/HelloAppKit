//
//  KeyValueCodingTests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 1/23/25.
//

import Foundation
import Testing

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107-SW1

struct KeyValueCodingTests {

    // KVC 사용하려면 NSObject 를 계승해야 한다.
    // KVC 에 사용할 프로퍼티들은 @objc 로 표시해둬야 한다.

    class Person: NSObject {
        @objc var name: String
        @objc var age: Int

        init(name: String = "", age: Int = 0) {
            self.name = name
            self.age = age
        }
    }

    class Transaction: NSObject {
        @objc var date: Date
        @objc var amount: Double
        @objc var descriptionText: String

        init(date: Date, amount: Double, descriptionText: String) {
            self.date = date
            self.amount = amount
            self.descriptionText = descriptionText
        }
    }

    class BankAccount: NSObject {
        @objc var accountNumber: String
        @objc var accountHolder: Person // To-One relationship
        @objc var transactions: [Transaction] // To-Many relationship
        @objc var balance: Double

        init(accountNumber: String, accountHolder: Person, transactions: [Transaction], balance: Double) {
            self.accountNumber = accountNumber
            self.accountHolder = accountHolder
            self.transactions = transactions
            self.balance = balance
        }
    }

    @Test func testKey() throws {
        let account = BankAccount(
            accountNumber: "123456789",
            accountHolder: Person(),
            transactions: [],
            balance: 1050.0
        )

        account.setValue(1600.0, forKey: "balance")

        let balance = account.value(forKey: "balance") as! Double
        let balance2 = account[keyPath: \.balance]

        #expect(balance == 1600.0)
        #expect(balance == balance2)
    }

    @Test func testToOneRelationship() throws {
        let account = BankAccount(
            accountNumber: "123456789",
            accountHolder: Person(),
            transactions: [],
            balance: 1050.0
        )

        account.setValue(Person(name: "Jane Smith", age: 28), forKey: "accountHolder")

        let accountHolder = account.value(forKey: "accountHolder") as! Person

        #expect(accountHolder.name == "Jane Smith")
        #expect(accountHolder.age == 28)
    }

    @Test func testToManyRelationship() throws {
        let transaction1 = Transaction(date: Date(), amount: -100.0, descriptionText: "Grocery Shopping")
        let transaction2 = Transaction(date: Date(), amount: 200.0, descriptionText: "Salary Deposit")
        let transaction3 = Transaction(date: Date(), amount: -50.0, descriptionText: "Restaurant Payment")

        let account = BankAccount(
            accountNumber: "123456789",
            accountHolder: Person(),
            transactions: [transaction1, transaction2, transaction3],
            balance: 1050.0
        )

        let newTransaction = Transaction(date: Date(), amount: -25.0, descriptionText: "Coffee Shop")
        account.mutableArrayValue(forKey: "transactions").add(newTransaction)

        let transactions = account.value(forKey: "transactions") as! [Transaction]

        #expect(transactions.count == 4)
        #expect(transactions[3].descriptionText == "Coffee Shop")
    }

    @Test func testKeyPath() throws {
        let person = Person(name: "John Doe", age: 35)

        let transaction1 = Transaction(date: Date(), amount: -100.0, descriptionText: "Grocery Shopping")
        let transaction2 = Transaction(date: Date(), amount: 200.0, descriptionText: "Salary Deposit")

        let account = BankAccount(
            accountNumber: "123456789",
            accountHolder: person,
            transactions: [transaction1, transaction2],
            balance: 1050.0
        )

        let accountHolderName = account.value(forKeyPath: "accountHolder.name") as! String
        #expect(accountHolderName == "John Doe")

        let accountHolderAge = account.value(forKeyPath: "accountHolder.age") as! Int
        #expect(accountHolderAge == 35)

        let transactionAmounts = account.value(forKeyPath: "transactions.amount") as! [Double]
        #expect(transactionAmounts == [-100.0, 200.0])

        let firstTransactionAmount = account.value(forKeyPath: "transactions.amount.@firstObject") as! Double
        #expect(firstTransactionAmount == -100.0)

        let maxTransactionAmount = account.value(forKeyPath: "transactions.@max.amount") as! Double
        #expect(maxTransactionAmount == 200.0)
    }

}
