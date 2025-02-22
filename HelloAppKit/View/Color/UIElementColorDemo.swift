//
//  UIElementColorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class UIElementColorDemo: ColorLabelListController {

    override func setupLabels() {
        addSectionLabel("Label Colors")
        addColorLabel("labelColor", .labelColor)
        addColorLabel("secondaryLabelColor", .secondaryLabelColor)
        addColorLabel("tertiaryLabelColor", .tertiaryLabelColor)
        addColorLabel("quaternaryLabelColor", .quaternaryLabelColor)

        addSectionLabel("Text Colors")
        addColorLabel("textColor", .textColor)
        addColorLabel("placeholderTextColor", .placeholderTextColor)
        addColorLabel("selectedTextColor", .selectedTextColor)
        addColorLabel("keyboardFocusIndicatorColor", .keyboardFocusIndicatorColor)
        addColorLabel("textColor / textBackgroundColor", .textColor, .textBackgroundColor)
        addColorLabel("selectedTextColor / selectedTextBackgroundColor", .selectedTextColor, .selectedTextBackgroundColor)
        addColorLabel("unemphasizedSelectedTextColor / unemphasizedSelectedTextBackgroundColor", .unemphasizedSelectedTextColor, .unemphasizedSelectedTextBackgroundColor)

        // [accentColor brightnessComponent] < 0.5) ? [NSColor whiteColor] : [NSColor blackColor]

        addSectionLabel("Content Colors")
        addColorLabel("linkColor", .linkColor)
        addColorLabel("separatorColor", .separatorColor)
        addColorLabel("selectedControlTextColor / selectedContentBackgroundColor", .selectedControlTextColor, .selectedContentBackgroundColor)
        addColorLabel("alternateSelectedControlTextColor / selectedContentBackgroundColor", .alternateSelectedControlTextColor, .selectedContentBackgroundColor)
        addColorLabel("secondaryLabelColor / unemphasizedSelectedContentBackgroundColor", .secondaryLabelColor, .unemphasizedSelectedContentBackgroundColor)

        addSectionLabel("Menu Colors")
        addColorLabel("selectedMenuItemTextColor", .selectedMenuItemTextColor)

        addSectionLabel("Table Colors")
        addColorLabel("labelColor / gridColor", .labelColor, .gridColor)
        addColorLabel("headerTextColor", .headerTextColor)
        addColorLabel("labelColor / alternatingContentBackgroundColors[0]", .labelColor, .alternatingContentBackgroundColors[0])
        addColorLabel("labelColor / alternatingContentBackgroundColors[1]", .labelColor, .alternatingContentBackgroundColors[1])

        addSectionLabel("Control Colors")
        addColorLabel("controlTextColor / controlColor", .controlTextColor, .controlColor)
        addColorLabel("disabledControlTextColor / controlColor", .disabledControlTextColor, .controlColor)
        addColorLabel("controlTextColor / controlAccentColor", .controlTextColor, .controlAccentColor)
        addColorLabel("alternateSelectedControlTextColor / controlAccentColor", .alternateSelectedControlTextColor, .controlAccentColor)
        addColorLabel("controlTextColor / controlBackgroundColor", .controlTextColor, .controlBackgroundColor)
        addColorLabel("selectedControlTextColor / selectedControlColor", .selectedControlTextColor, .selectedControlColor)
        addColorLabel("alternateSelectedControlTextColor / selectedControlColor", .alternateSelectedControlTextColor, .selectedControlColor)
        addColorLabel("scrubberTexturedBackground", .controlTextColor, .scrubberTexturedBackground)

        addSectionLabel("Window Colors")
        addColorLabel("windowBackgroundColor", .textColor, .windowBackgroundColor)
        addColorLabel("windowFrameTextColor", .windowFrameTextColor)
        addColorLabel("underPageBackgroundColor", .textColor, .underPageBackgroundColor)

        addSectionLabel("Highlights and Shadows")
        addColorLabel("findHighlightColor", .findHighlightColor)
        addColorLabel("highlightColor", .highlightColor)
        addColorLabel("shadowColor", .shadowColor)
    }

}
