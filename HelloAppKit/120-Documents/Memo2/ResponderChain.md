
#  Responder Chain

## Document 기반 App의 Responder Chain 구조, GPT 답변 결과.

Document App에서 Responder Chain의 기본적인 구성은 다음과 같습니다:
 
## 현재 포커스된 NSView

이벤트는 가장 구체적인 뷰 객체에서 시작됩니다.
예: 텍스트 필드, 버튼, 커스텀 뷰 등.

## 해당 뷰의 NSViewController

뷰 컨트롤러는 현재 뷰 계층과 연결되어 있으며, 뷰에서 처리되지 않은 이벤트를 받을 수 있습니다.

## NSWindow

각 문서는 별도의 윈도우 객체를 가집니다. 윈도우는 뷰에서 처리되지 않은 이벤트를 받습니다.

## NSWindowController

윈도우와 연결된 윈도우 컨트롤러는 추가적인 이벤트 처리를 수행할 수 있습니다.

## NSDocument

Document 기반 앱에서는 해당 윈도우에 연결된 NSDocument 객체가 Responder Chain에 포함됩니다.
문서와 관련된 작업(예: 저장, 열기, 내보내기 등)을 처리할 수 있습니다.

## NSDocumentController

앱의 중앙에서 문서 관련 작업을 관리합니다.
예: 새로운 문서 생성, 기존 문서 열기, 모든 문서 저장 등.

## NSApplication

앱 전체에서 처리되지 않은 이벤트를 최종적으로 받습니다.
