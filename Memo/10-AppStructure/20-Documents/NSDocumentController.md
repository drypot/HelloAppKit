# NSDocumentController

https://developer.apple.com/documentation/appkit/nsdocumentcontroller

NSDocumentController object is a high-level controller.
New, Open 등 메뉴바 이벤트에 응하는 기능들을 한다.

NSDocumentController 는 사용자가 커스터마이징할 필요가 없다.
애플이 준 대로 그냥 쓰면 된다.

NSDocumentController 를 서브클래싱할 필요가 있는 경우에는
대부분 NSApplicationDelegate 으로 처리할 수 있다.

File Menu -> New -> Information property list -> appropriate NSDocument subclass
-> NSDocumentController -> allocate NSDocument

File Menu -> Open -> NSDocumentController -> Open dialog -> user selection
-> finds the NSDocument subclass for the file -> allocate NSDocument

위 두 경우 모두 NSDocumentController는 document에 관한 레퍼런스를 내부에 보관한다.

