
# NSApplication

https://developer.apple.com/documentation/appkit/nsapplication
https://developer.apple.com/documentation/appkit/nsapplicationdelegate

모든 App 은 NSApplication 싱글 인스턴스를 가진다.
NSApplication 인스턴스는 이벤트 루프, 윈도우, 메뉴, 이벤트 배분을 컨트롤한다.

NSApplication 은 NSApplicationDelegate 를 받는다.
사용자는 NSApplication 를 계승하는 대신 커스텀 NSApplicationDelegate 를 만들어 쓴다.

main() 은 NSApplicationMain() 을 부른다.
여기서 NSApplication shared 가 만들어 진다.
shared 가 만들어 지면서 Window Server 와 App 이 연결된다.
이후엔 NSApplication.shared 대신 전역 변수인 NSApp 을 사용하면 된다.

NSApplication 은 앱이 사용하는 모든 NSWindow 인스턴스의 목록을 관리한다.

NSApp은 window server로부터 이벤트를 받아서 NSEvent로 변형한 만든 다음 적당한 NSResponder에 분배한다.
NSApp은 NSWindow 오브젝트에 이벤트를 전달한다.
대부분의 마우스, 키보드 이벤트는 관련된 NSWindow 오브젝트에 전달된다.
단 Command key 가 눌린 키보드 이벤트는 모든 NSWindow 오브젝트가 응답할 기회를 가진다.

NSWindow가 NSApp 으로부터 NSEvent를 받으면, 자신의 뷰 트리에 분배한다.

NSApplication 은 NSApplicationDelegate 에 다이렉트로 메시지를 보내기도 하고,
디볼트 NSNotificationCenter에 알림을 보내기도 한다.
디볼트 NSNotificationCenter에 addObserver로 핸들러를 등록해 둘 수 있다.

