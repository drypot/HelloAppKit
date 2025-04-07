//
//  NSStringTests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 3/29/25.
//

import Foundation
import Testing

struct NSStringTests {

    @Test func testLineCount() throws {

        // components(separatedBy: .newlines) 는 CR LF 연속을 두 개의 구분자로 본다.

        let text = "line 1\nline 2\rline 3\r\nline 4"
        let lines = text.components(separatedBy: .newlines)

        #expect(lines == [
            "line 1",
            "line 2",
            "line 3",
            "",
            "line 4"
        ])
    }

    @Test func testLineRangeFor() throws {

        // TextKit 1 문서 보다가 잠깐 테스트 만들어봤다.
        // Counting Lines of Text
        // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html

        let logger = SimpleLogger<String>()

        let text = "line 1\nline 2\rline 3\r\nline 4" as NSString
        let length = text.length

        var index = 0
        while(index < length) {
            let firstCharacterRange = NSRange(location: index, length: 0)
            let lineRange = text.lineRange(for: firstCharacterRange)
            let subString = String(text.substring(with: lineRange))
            logger.append(subString)
            index = NSMaxRange(lineRange)
        }

        #expect(logger.result() == [
            "line 1\n",
            "line 2\r",
            "line 3\r\n",
            "line 4"
        ])
    }

    @Test func testLineRangeForInMiddle() throws {
        let text = "line 1\nline 2\rline 3\r\nline 4" as NSString
        //let length = text.length

        // location 을 라인 중간에 줘도 리턴되는 lineRange 가 라인 처음부터 계산된다.

        let index = 3
        let firstCharacterRange = NSRange(location: index, length: 0)
        let lineRange = text.lineRange(for: firstCharacterRange)
        let subString = String(text.substring(with: lineRange))

        #expect(subString == "line 1\n")
    }
}
