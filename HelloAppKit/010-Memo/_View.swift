//
//  _View.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/26/24.
//

import Foundation

// Introduction to View Programming Guide for Cocoa
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaViewsGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40002978



// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/EventOverview/Introduction/Introduction.html#//apple_ref/doc/uid/10000060i

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaDrawingGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40003290


// https://developer.apple.com/documentation/appkit/nsview

// If you subclass NSView directly and handle specific types of events,
// don’t call super in the implementations of your event-related methods.
// Views inherit their event-handling capabilities from their NSResponder parent class.
// The default behavior for responders is to pass events up the responder chain,
// which isn’t the behavior you typically want for a custom view.
// Therefore, don’t call super if your view implements any of the following methods ...

