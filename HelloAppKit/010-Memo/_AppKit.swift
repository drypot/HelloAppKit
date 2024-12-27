//
//  _AppKit.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/23/24.
//

import Foundation

// https://developer.apple.com/documentation/appkit
// https://developer.apple.com/design/human-interface-guidelines/designing-for-macos


// https://developer.apple.com/documentation/appkit/nswindowcontroller

// A window controller can manage a window by itself
// or as a role player in AppKit’s document-based architecture

// Although a window controller can manage a programmatically created window,
// it usually manages a window in a nib file.
// The window controller is usually the owner of the nib file.

// For documents with multiple windows or panels,
// your document must create separate instances of NSWindowController for each window or panel,
// (or of custom subclasses of NSWindowController)

// NSWindowController 생성에는 왠만하면 init(window:) 를 쓰라고 한다.


