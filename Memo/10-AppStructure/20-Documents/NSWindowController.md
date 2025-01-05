
# NSWindowController

https://developer.apple.com/documentation/appkit/nsdocumentcontroller

NSDocumentController is the first-responder target of New and Open menu commands. 

NSDocumentController creates and opens documents and tracks them throughout a session of the app.

When opening documents, a document controller runs and manages the modal Open panel. 

NSDocumentController objects also maintain and manage the mappings of document types, 
loaded from the information property list (Info.plist).

NSDocumentController management of the Open Recent menu is useful in apps 
that don’t use subclasses of NSDocument

https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/KeyObjects/KeyObjects.html#//apple_ref/doc/uid/TP40011179-CH3-SW6

You Should Subclass NSWindowController

You should not force the windows to be visible in makeWindowControllers.
NSDocument does that for you if it’s appropriate.


