## Document-Based App Programming Guide for Mac

https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011179

A document, an instance of an NSDocument subclass, is
a controller that manages the app’s data model.

You must design and implement your app’s data model.
you must override one document reading method and one document writing method.

## Document App 만드는 순서.

1. View 를 구성
2. Menu bar commands 들을 세팅, Connect menu item to a first responder method
3. Project -> Target -> Info -> Document Types 세팅
https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/ApplicationCreationProcess/ApplicationCreationProcess.html#//apple_ref/doc/uid/TP40011179-CH6-997699

4. If you define a custom document type with its own UTI, you must export the UTI.
커스텀 UTI 를 정의해야 하는 경우, Exported UTI를 세팅.

5. Implement the NSDocument Subclass


## Creating the Subclass of NSDocument

https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/ManagingLifecycle/ManagingLifecycle.html
