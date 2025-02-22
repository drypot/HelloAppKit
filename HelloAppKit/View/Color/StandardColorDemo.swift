//
//  StandardColorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class StandardColorDemo: ColorLabelListController {

    override func setupLabels() {
        addSectionLabel("Adaptable System Colors")
        addColorLabel("systemBlue", .systemBlue)
        addColorLabel("systemBrown", .systemBrown)
        addColorLabel("systemCyan", .systemCyan)
        addColorLabel("systemGray", .systemGray)
        addColorLabel("systemGreen", .systemGreen)
        addColorLabel("systemIndigo", .systemIndigo)
        addColorLabel("systemMint", .systemMint)
        addColorLabel("systemOrange", .systemOrange)
        addColorLabel("systemPink", .systemPink)
        addColorLabel("systemPurple", .systemPurple)
        addColorLabel("systemRed", .systemRed)
        addColorLabel("systemTeal", .systemTeal)
        addColorLabel("systemYellow", .systemYellow)

        addSectionLabel("Transparent Colors")
        addColorLabel("clear", .textColor, .clear)

        addSectionLabel("Fixed Colors")
        addColorLabel("black", .black)
        addColorLabel("blue", .blue)
        addColorLabel("brown", .brown)
        addColorLabel("cyan", .cyan)
        addColorLabel("darkGray", .darkGray)
        addColorLabel("gray", .gray)
        addColorLabel("lightGray", .lightGray)
        addColorLabel("magenta", .magenta)
        addColorLabel("orange", .orange)
        addColorLabel("purple", .purple)
        addColorLabel("red", .red)
        addColorLabel("white", .white)
        addColorLabel("yellow", .yellow)
    }

}
