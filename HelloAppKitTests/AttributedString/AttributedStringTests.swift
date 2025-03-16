//
//  AttributedStringTests.swift
//  HelloAppKitTests
//
//  Created by Kyuhyun Park on 3/16/25.
//

import AppKit
import Testing

// AttributedString: Making Text More Beautiful Than Ever
// https://fatbobman.com/en/posts/attributedstring/

struct AttributedStringTests {

    @Test func test() throws {
        let string = AttributedString("Thank you! please visit our website.")

        #expect(string.characters.count == 36)
        #expect(string.runs.count == 1)
    }

    @Test func testAttrToWholeString() throws {
        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.foregroundColor == nil)

        // 아래 3 줄은 효과가 같다.

        string[AttributeScopes.AppKitAttributes.ForegroundColorAttribute.self] = .systemRed
        #expect(string.foregroundColor == .systemRed)

        string.appKit.foregroundColor = .systemBlue
        #expect(string.foregroundColor == .systemBlue)

        string.foregroundColor = .systemTeal
        #expect(string.foregroundColor == .systemTeal)
    }

    @Test func testAttrToRange() throws {
        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.runs.count == 1)

        if let range = string.range(of: "website") {
            string[range].link = URL(string: "https://google.com")
        }

        #expect(string.runs.count == 3)
    }

    @Test func testManualRange() throws {
        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.runs.count == 1)

        let start = string.characters.index(string.startIndex, offsetBy: 11)
        let end = string.characters.index(start, offsetBy: 6)
        string[start..<end].foregroundColor = .systemTeal

        #expect(string.runs.count == 3)
    }

    @Test func testAttributeContainer() throws {
        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.foregroundColor == nil)

        var container = AttributeContainer()
        container.foregroundColor = .systemTeal

        string.mergeAttributes(container)

        #expect(string.foregroundColor == .systemTeal)
    }

    @Test func testCharactersLoop() throws {
        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.runs.count == 1)

        let characters = string.characters

        for i in characters.indices where characters[i].isPunctuation {
            let range = i..<characters.index(after: i)
            string[range].foregroundColor = .systemTeal
        }

        #expect(string.runs.count == 4)

        let range = string.range(of: "!")!

        #expect(string[range].foregroundColor == .systemTeal)
    }

    @Test func testRun() throws {
        var string = AttributedString("Thank you! please visit our website.")

        if let range = string.range(of: "website") {
            string[range].link = URL(string: "https://google.com")
        }

        let firstRun = string.runs.first { run in
            return run.link != nil
        }!
        let firstString = String(string.characters[firstRun.range])

        #expect(firstString == "website")
    }

    @Test func testRunWithKeyPath() throws {
        var string = AttributedString("Thank you! please visit our website.")

        if let range = string.range(of: "website") {
            string[range].link = URL(string: "https://google.com")
        }

        // 어트리뷰트가 복잡하면
        // runs 에 KeyPath 를 줘서 해당 Key 만으로 run 셋을 만들 수도 있다.

        let runs = string.runs[\.link]
        let (firstLink, firstRange) = runs.first { link, range in link != nil }!
        let firstString = String(string.characters[firstRange])

        #expect(firstLink!.absoluteString == "https://google.com")
        #expect(firstString == "website")
    }

    @Test func testExplicitAttributeScope() throws {
        var string = AttributedString("Thank you! please visit our website.")

        if let range = string.range(of: "website") {
            string[range].foregroundColor = .systemTeal
        }

        let firstRun = string.runs.first { run in
            // nil 같은 애매한 상수 때문에 타입 매칭을 잘못하면,
            // appKit 등 AttributeScope 를 명시적으로 적어줘야 한다.
            return run.appKit.foregroundColor != nil
        }!
        let firstString = String(string.characters[firstRun.range])

        #expect(firstString == "website")
    }

    @Test func testReplaceSubrange() throws {
        var string = AttributedString("Thank you! please visit our website.")

        if let range = string.range(of: "website") {
            string[range].foregroundColor = .systemTeal
            string.characters.replaceSubrange(range, with: "instagram")
        }

        #expect(string.runs.count == 3)

        let firstString = String(string.characters)

        #expect(firstString == "Thank you! please visit our instagram.")
    }

    @Test func testCustomAttribute() throws {

        struct CustomAttribute: CodableAttributedStringKey, MarkdownDecodableAttributedStringKey {
            enum Value: String, Codable {
                case plain
                case fun
                case extreme
            }
            static let name = "customAttribute"
        }

        var string = AttributedString("Thank you! please visit our website.")

        #expect(string.runs.count == 1)

        if let range = string.range(of: "website") {
            string[range][CustomAttribute.self] = .extreme
        }

        #expect(string.runs.count == 3)

        let runs = string.runs[CustomAttribute.self]
        let (firstAttr, firstRange) = runs.first { customAttr, range in customAttr != nil }!
        let firstString = String(string.characters[firstRange])

        #expect(firstAttr == .extreme)
        #expect(firstString == "website")
    }

}
