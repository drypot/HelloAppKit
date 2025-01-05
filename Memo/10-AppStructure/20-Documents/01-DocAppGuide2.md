#  Developing a Document-Based App

https://developer.apple.com/documentation/appkit/developing-a-document-based-app

In the Cocoa document architecture,
your document is represented by a custom subclass of NSDocument.

Each NSDocument has its own NSWindowController,
which in turn creates an NSWindow object for displaying the document content.

NSDocumentController to manage documents.

NSDocumentController -> NSDocument -> NSWindowController -> NSWindow
