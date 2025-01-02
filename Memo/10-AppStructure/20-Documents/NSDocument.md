# NSDocument 

https://developer.apple.com/documentation/appkit/developing-a-document-based-app

In the Cocoa document architecture,
your document is represented by a custom subclass of NSDocument.

Each NSDocument has its own NSWindowController,
which in turn creates an NSWindow object for displaying the document content.

NSDocumentController to manage documents.

NSDocumentController -> NSDocument -> NSWindowController -> NSWindow

https://developer.apple.com/documentation/appkit/nsdocument

Documents respond to first-responder action messages to save, revert, and print their data.

Document-Based App Programming Guide for Mac
https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011179

A document, an instance of an NSDocument subclass, is
a controller that manages the app’s data model.

You must design and implement your app’s data model.
you must override one document reading method and one document writing method.


 Document 기반 App의 Responder Chain 구조, GPT 답변 결과.

 Document App에서 Responder Chain의 기본적인 구성은 다음과 같습니다:
 1.    현재 포커스된 NSView
 •    이벤트는 가장 구체적인 뷰 객체에서 시작됩니다.
 •    예: 텍스트 필드, 버튼, 커스텀 뷰 등.

 2.    해당 뷰의 NSViewController
 •    뷰 컨트롤러는 현재 뷰 계층과 연결되어 있으며, 뷰에서 처리되지 않은 이벤트를 받을 수 있습니다.

 3.    NSWindow
 •    각 문서는 별도의 윈도우 객체를 가집니다. 윈도우는 뷰에서 처리되지 않은 이벤트를 받습니다.

 4.    NSWindowController
 •    윈도우와 연결된 윈도우 컨트롤러는 추가적인 이벤트 처리를 수행할 수 있습니다.

 5.    NSDocument
 •    Document 기반 앱에서는 해당 윈도우에 연결된 NSDocument 객체가 Responder Chain에 포함됩니다.
 •    문서와 관련된 작업(예: 저장, 열기, 내보내기 등)을 처리할 수 있습니다.

 6.    NSDocumentController
 •    앱의 중앙에서 문서 관련 작업을 관리합니다.
 •    예: 새로운 문서 생성, 기존 문서 열기, 모든 문서 저장 등.

 7.    NSApplication
 •    앱 전체에서 처리되지 않은 이벤트를 최종적으로 받습니다.

## Document App 만드는 순서.

1. View 를 구성
2. Menu bar commands 들을 세팅, Connect menu item to a first responder method
3. Project -> Target -> Info -> Document Types 세팅
https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/ApplicationCreationProcess/ApplicationCreationProcess.html#//apple_ref/doc/uid/TP40011179-CH6-997699

4. If you define a custom document type with its own UTI, you must export the UTI.
커스텀 UTI 를 정의해야 하는 경우, Exported UTI를 세팅.

5. Implement the NSDocument Subclass


## Introduction to Application Menus and Pop-up Lists

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MenuList/MenuList.html#//apple_ref/doc/uid/10000032i

about menu validation and other menu topics.

Uniform Type Identifiers Overview
https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html#//apple_ref/doc/uid/TP40001319

Uniform Type Identifiers Reference
https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009257

Information Property List Key Reference
https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009247


## Creating the Subclass of NSDocument

https://developer.apple.com/library/archive/documentation/DataManagement/Conceptual/DocBasedAppProgrammingGuideForOSX/ManagingLifecycle/ManagingLifecycle.html

