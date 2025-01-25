//
//  StringTests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 10/2/24.
//

import Testing
@testable import HelloAppKit

struct StringTests {

    @Test func testDropSuffix() async throws {
        #expect("HelloWorld".dropSuffix("World") == "Hello")
        #expect("HelloWorld".dropSuffix("Ground") == "HelloWorld")
    }

}
