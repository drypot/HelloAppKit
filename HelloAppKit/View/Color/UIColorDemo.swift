//
//  UIColorDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 2/20/25.
//

import Cocoa

class UIColorDemo: ColorLabelListController {

    override func setupLabels() {
        addSectionLabel("Label Colors")
        addColorLabel("labelColor / clear", .labelColor, .clear)
        addColorLabel("labelColor / windowBackgroundColor", .labelColor, .windowBackgroundColor)
        addColorLabel("labelColor / textBackgroundColor", .labelColor, .textBackgroundColor)
        addColorLabel("secondaryLabelColor / textBackgroundColor", .secondaryLabelColor, .textBackgroundColor)
        addColorLabel("tertiaryLabelColor / textBackgroundColor", .tertiaryLabelColor, .textBackgroundColor)
        addColorLabel("quaternaryLabelColor / textBackgroundColor", .quaternaryLabelColor, .textBackgroundColor)
        addColorLabel("windowFrameTextColor / clear", .windowFrameTextColor, .clear)

        addSectionLabel("Text Colors")
        addColorLabel("textColor / textBackgroundColor", .textColor, .textBackgroundColor)
        addColorLabel("selectedTextColor / selectedTextBackgroundColor", .selectedTextColor, .selectedTextBackgroundColor)
        addColorLabel("unemphasizedSelectedTextColor / unemphasizedSelectedTextBackgroundColor", .unemphasizedSelectedTextColor, .unemphasizedSelectedTextBackgroundColor)
        addColorLabel("linkColor / textBackgroundColor", .linkColor, .textBackgroundColor)

        addSectionLabel("Table Colors")
        addColorLabel("headerTextColor / controlBackgroundColor", .headerTextColor, .controlBackgroundColor)
        addColorLabel("gridColor / controlBackgroundColor", .labelColor, .controlBackgroundColor)
        addColorLabel("labelColor / alternatingContentBackgroundColors[0]", .labelColor, .alternatingContentBackgroundColors[0])
        addColorLabel("labelColor / alternatingContentBackgroundColors[1]", .labelColor, .alternatingContentBackgroundColors[1])

        addSectionLabel("Content Colors")
        addColorLabel("alternateSelectedControlTextColor / selectedContentBackgroundColor", .alternateSelectedControlTextColor, .selectedContentBackgroundColor)
        addColorLabel("unemphasizedSelectedTextColor / unemphasizedSelectedContentBackgroundColor", .unemphasizedSelectedTextColor, .unemphasizedSelectedContentBackgroundColor)

        addSectionLabel("Control Colors")
        addColorLabel("controlAccentColor / controlColor", .controlAccentColor, .controlColor)
        addColorLabel("controlTextColor / controlColor", .controlTextColor, .controlColor)
        addColorLabel("controlTextColor / controlBackgroundColor", .controlTextColor, .controlBackgroundColor)
        addColorLabel("disabledControlTextColor / controlColor", .disabledControlTextColor, .controlColor)
        addColorLabel("placeholderTextColor / controlColor", .placeholderTextColor, .controlColor)
        addColorLabel("keyboardFocusIndicatorColor / controlColor", .keyboardFocusIndicatorColor, .controlColor)
        addColorLabel("selectedControlTextColor / selectedControlColor", .selectedControlTextColor, .selectedControlColor)
        addColorLabel("separatorColor / controlColor", .separatorColor, .textBackgroundColor)
        // addColorLabel("scrubberTexturedBackground", .controlTextColor, .scrubberTexturedBackground)

        // [accentColor brightnessComponent] < 0.5) ? [NSColor whiteColor] : [NSColor blackColor]

        addSectionLabel("Menu Colors")
        addColorLabel("selectedMenuItemTextColor / selectedContentBackgroundColor", .selectedMenuItemTextColor, .selectedContentBackgroundColor)

        addSectionLabel("Window Colors")
        addColorLabel("windowFrameTextColor / windowBackgroundColor", .windowFrameTextColor, .windowBackgroundColor)
        addColorLabel("windowFrameTextColor / underPageBackgroundColor", .windowFrameTextColor, .underPageBackgroundColor)

        addSectionLabel("Highlights and Shadows")
        addColorLabel("textColor / findHighlightColor", .textColor, .findHighlightColor)
        addColorLabel("textColor / highlightColor", .textColor, .highlightColor)
        addColorLabel("shadowColor / textBackgroundColor", .shadowColor, .textBackgroundColor)
    }

}
