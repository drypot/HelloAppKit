# NSViewController

 https://developer.apple.com/documentation/appkit/nsviewcontroller

 Prior to OS X v10.10,
 a typical usage pattern for loading a nib file was to subclass NSViewController
 and override its loadView() method to call [super loadView].

 But in macOS 10.10 and later,
 the loadView() method automatically looks for a nib file with the same name as the view controller.
 To take advantage of this behavior, name a nib file after its corresponding view controller
 and pass nil to both parameters of the init(nibName:bundle:) method.

 프로그래밍적으로 NSViewController 를 생성하려면
 init(nibName: nil, bundle: nil) 로 컨트롤러 생성하고,
 override func loadView() 해서 이 안에서 View 들을 만들어야 한다.
 loadView() 안에서 super.loadView() 는 호출해선 안 된다.
 super.loadView() 는 기본 nib 파일에서 컨트롤러를 로드하려고 할 것이다.

 https://www.cocoawithlove.com/2008/07/better-integration-for-nsviewcontroller.html

 From Mac OS X 10.5 Leopard (2007년 10월), 
 NSViewController began offering similar from-NIB loading convenience for NSViews.
 This allows higher level context and dynamic configuration of regions of a window,
 rather than purely at the coarse level of the whole window.



