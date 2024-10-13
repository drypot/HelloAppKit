//
//  CustomTextStorage.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/20/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), 215p

class CustomTextStorage: NSTextStorage {
    
    let textContent = NSMutableAttributedString()
    
    let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor.darkGray]
    let highlights: [String: NSColor] = ["red": .red, "blue": .blue, "green": .green]
    
    override var string: String {
        return textContent.string
    }
    
    override func attributes(
        at location: Int,
        effectiveRange range: NSRangePointer?
    ) -> [NSAttributedString.Key: Any] {
        
        return textContent.attributes(
            at: location,
            effectiveRange: range
        )
    }
    
    override func replaceCharacters(
        in range: NSRange,
        with str: String
    ) {
            
        beginEditing()
        textContent.replaceCharacters(
            in: range,
            with: str
        )
        edited(
            [.editedCharacters, .editedAttributes],
            range: range,
            changeInLength: (str as NSString).length - range.length
        )
        endEditing()
    }
    
    override func setAttributes(
        _ attrs: [NSAttributedString.Key: Any]?,
        range: NSRange
    ) {
        beginEditing()
        textContent.setAttributes(
            attrs,
            range: range
        )
        edited(
            .editedAttributes,
            range: range,
            changeInLength: 0
        )
        endEditing()
    }

    override func processEditing() {
        var range = NSUnionRange(
            self.editedRange,
            NSString(string: textContent.string)
                .lineRange(for: NSMakeRange(self.editedRange.location, 0))
        )
        range = NSUnionRange(
            self.editedRange,
            NSString(string: textContent.string)
                .lineRange(for: NSMakeRange(NSMaxRange(self.editedRange), 0))
        )
        applyStyles(range: range)
        super.processEditing()
    }
    
    func applyStyles(range: NSRange) {
        print("---")
        for (string, color) in highlights {
            print("\(string)")
            let regexStr = "\\b\(string)\\b"
            do {
                let regex = try NSRegularExpression(pattern: regexStr, options: [])
                regex.enumerateMatches(in: textContent.string, options: [], range: range) { match, flags, stop in
                    guard let match else { return }
                    let matchRange = match.range(at: 0)
                    self.addAttributes([.foregroundColor: color], range: matchRange)
                    let maxRange = matchRange.location + matchRange.length
                    print("\(string): \(matchRange.location), \(matchRange.length), \(self.length)")
                    if maxRange + 1 < self.length {
                        print("if then \(string)")
                        self.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
                    }
                }
            }
            catch {
                print(error)
            }
        }
    }
}
