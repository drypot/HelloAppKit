//
//  SystemColorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class SystemColorDemo: ColorLabelListController {

    override func setupLabels() {
        addSectionLabel("Adaptable System Colors")
        addColorLabel("systemBlue", .systemBlue, .textBackgroundColor)
        addColorLabel("systemBrown", .systemBrown, .textBackgroundColor)
        addColorLabel("systemCyan", .systemCyan, .textBackgroundColor)
        addColorLabel("systemGray", .systemGray, .textBackgroundColor)
        addColorLabel("systemGreen", .systemGreen, .textBackgroundColor)
        addColorLabel("systemIndigo", .systemIndigo, .textBackgroundColor)
        addColorLabel("systemMint", .systemMint, .textBackgroundColor)
        addColorLabel("systemOrange", .systemOrange, .textBackgroundColor)
        addColorLabel("systemPink", .systemPink, .textBackgroundColor)
        addColorLabel("systemPurple", .systemPurple, .textBackgroundColor)
        addColorLabel("systemRed", .systemRed, .textBackgroundColor)
        addColorLabel("systemTeal", .systemTeal, .textBackgroundColor)
        addColorLabel("systemYellow", .systemYellow, .textBackgroundColor)

        addSectionLabel("Fixed Colors")
        addColorLabel("black / white", .black, .white)
        addColorLabel("blue", .blue, .textBackgroundColor)
        addColorLabel("brown", .brown, .textBackgroundColor)
        addColorLabel("cyan", .cyan, .textBackgroundColor)
        addColorLabel("darkGray", .darkGray, .textBackgroundColor)
        addColorLabel("gray", .gray, .textBackgroundColor)
        addColorLabel("lightGray", .lightGray, .textBackgroundColor)
        addColorLabel("magenta", .magenta, .textBackgroundColor)
        addColorLabel("orange", .orange, .textBackgroundColor)
        addColorLabel("purple", .purple, .textBackgroundColor)
        addColorLabel("red", .red, .textBackgroundColor)
        addColorLabel("yellow", .yellow, .textBackgroundColor)

        addSectionLabel("Transparent Colors")
        addColorLabel("textColor / clear", .textColor, .clear)

    }

}
