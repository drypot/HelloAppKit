//
//  UTITests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 1/5/25.
//

import Foundation
import UniformTypeIdentifiers
import Testing

// https://developer.apple.com/documentation/uniformtypeidentifiers

struct UTITests {

    @Test func test() throws {
        let text = UTType.plainText
        #expect(text.description == "public.plain-text")
        #expect(text.localizedDescription == "text")
        #expect(text.preferredMIMEType == "text/plain")
        #expect(text.identifier == "public.plain-text")
        #expect(text.preferredFilenameExtension == "txt")
        #expect(text.isDynamic == false)
        #expect(text.isPublic == true)
        #expect(text.isDeclared == true)
    }

}
