//
//  TextSample.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/18/25.
//

import Foundation
import AppKit

let textSample: String = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.
    Nisi ut aliquip ex ea commodo consequat.
    Duis aute irure dolor in reprehenderit in voluptate velit esse.
    Cillum dolore eu fugiat nulla pariatur.
    Excepteur sint occaecat cupidatat non proident, sunt in culpa.
    Qui officia deserunt mollit anim id est laborum.
    Vestibulum ac diam sit amet quam vehicula elementum.
    Amet consectetur adipiscing elit duis tristique sollicitudin nibh.
    Pellentesque habitant morbi tristique senectus et netus et malesuada.
    Fames ac turpis egestas integer eget aliquet nibh praesent.
    Tristique senectus et netus et malesuada fames ac turpis.
    Egestas integer eget aliquet nibh praesent tristique magna.
    Sit amet consectetur adipiscing elit duis tristique sollicitudin.
    Nibh praesent tristique magna sit amet purus gravida quis.
    Blandit turpis cursus in hac habitasse platea dictumst quisque.
    Sagittis id consectetur purus ut faucibus pulvinar elementum integer.
    Enim ut sem viverra aliquet eget sit amet tellus cras.
    Adipiscing elit duis tristique sollicitudin nibh sit amet commodo.
    """

func makeSampleAttrString(_ title: String) -> NSAttributedString {
    let font = NSFont.preferredFont(forTextStyle: .title1)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.3

    let attrString = NSAttributedString(
        string: title + "\n\n" + textSample,
        attributes: [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor: NSColor.textColor,
            .backgroundColor: NSColor.textBackgroundColor,
        ]
    )

    return attrString
}

// 번들 menu.rtf 파일 읽는 코드
//
// @objc func loadSampleAction(_ sender: NSButton) {
//     if let docURL = Bundle.main.url(forResource: "menu", withExtension: "rtf") {
//         do {
//             textStorage!.setAttributedString(NSAttributedString(string: ""))
//             try textStorage!.read(from: docURL, documentAttributes: nil, error: ())
//         } catch {
//             print("read error")
//         }
//     }
// }
