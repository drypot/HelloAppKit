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

@MainActor
func makeSampleAttrString(_ title: String) -> NSAttributedString {
    return NSAttributedString(
        string: title + "\n\n" + textSample,
        attributes: makeSampleAttr()
    )
}

@MainActor
func makeSampleAttr() -> [NSAttributedString.Key : Any] {
    let font = NSFont.preferredFont(forTextStyle: .title1)

    let lineHeightMultiple = 1.7

    let fontHeight = font.ascender + abs(font.descender) // + font.leading
    let lineHeight = fontHeight * lineHeightMultiple
    let baselineOffset = (lineHeight - fontHeight) / 2

    // lineSpacing 을 쓰면 Enter 후 빈줄에서 커서가 커지는 현상이 발생한다.
    // 문자를 입력하면 다시 줄어든다.

    // lineHeightMultiple 을 쓰면 커서가 위로 삐죽이 올라온다.

    // minimumLineHeight 를 주고 baselineOffset 을 조절하는 것이 무난해 보인다.

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.0
    paragraphStyle.minimumLineHeight = lineHeight
    paragraphStyle.maximumLineHeight = lineHeight

    let attr: [NSAttributedString.Key : Any] = [
        .font: font,
        .paragraphStyle: paragraphStyle,
        .baselineOffset: baselineOffset,
        .foregroundColor: NSColor.textColor,
        .backgroundColor: NSColor.textBackgroundColor,
    ]

    return attr
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
