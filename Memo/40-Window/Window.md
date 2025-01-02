# Window

 https://developer.apple.com/documentation/appkit
 https://developer.apple.com/design/human-interface-guidelines/designing-for-macos

 https://developer.apple.com/documentation/appkit/nsapplication

 NSApplication 에는 windows 라는 어레이가 있다.
 생성된 NSWindow 들의 strong reference 를 유지한다.
 그러므로 NSWindow 의 레퍼런스를 내가 별도로 유지할 필요는 없다.

 NSWindowController에 관한 레퍼런스는 시스템이 유지하지 않으므로 직접 유지해야 한다.

 https://stackoverflow.com/questions/78683776/programmatically-created-nswindow-crashes-upon-close
 윈도우 오브젝트 Retain에 관한 역사

 ARC 이전엔 retain/release 를 수작업으로 했다.
 윈도우를 만든 후 레퍼런스를 어디에 심지 않고 그냥 리턴해 버려도 됐다.
 releasedWhenClosed = YES, 해두고 나중에 release 했다.
 이 시나리오는 이 시절에나 사용할 수 있었다.

 ARC 가 나왔다.
 과거 방식으로 윈도우를 만들고 함수를 리턴해 버리면 레퍼런스 유지가 안 되서 윈도우가 날아가 버렸다.
 해서 호환성을 위해 AppKit 내부에서 레퍼런스를 유지하는 식으로 바뀌었다. OS X 10.13
 윈도우를 닫으면 AppKit이 레퍼런스 카운터를 빼면서 윈도우 오브젝트가 릴리즈 됐다.
 이 시나리오에서 releasedWhenClosed = true 하면 카운터가 두 번 빠지면서 스래쉬가 난다.

 ARC 환경에선 isReleasedWhenClosed는 항상 false 여야 한다.


 https://developer.apple.com/documentation/appkit/nswindowcontroller

 A window controller can manage a window by itself
 or as a role player in AppKit’s document-based architecture

 Although a window controller can manage a programmatically created window,
 it usually manages a window in a nib file.
 The window controller is usually the owner of the nib file.

 For documents with multiple windows or panels,
 your document must create separate instances of NSWindowController for each window or panel,
 (or of custom subclasses of NSWindowController)

 NSWindowController 생성에는 왠만하면 init(window:) 를 쓰라고 한다.

