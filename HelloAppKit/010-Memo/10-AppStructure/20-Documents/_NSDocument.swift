//
//  _NSDocument.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 12/29/24.
//

// https://developer.apple.com/documentation/appkit/developing-a-document-based-app

// In the Cocoa document architecture,
// your document is represented by a custom subclass of NSDocument.

// Each NSDocument has its own NSWindowController,
// which in turn creates an NSWindow object for displaying the document content.

// NSDocumentController to manage documents.

// NSDocumentController -> NSDocument -> NSWindowController -> NSWindow

// https://developer.apple.com/documentation/appkit/nsdocument

// Documents respond to first-responder action messages to save, revert, and print their data.

// https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011179

// A document, an instance of an NSDocument subclass, is
// a controller that manages the app’s data model.

// You must design and implement your app’s data model.
// you must override one document reading method and one document writing method.

