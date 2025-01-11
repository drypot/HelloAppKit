# NSDocument 

https://developer.apple.com/documentation/appkit/nsdocument

## Overview

A document is an object that can internally represent data displayed in a window.

Documents respond to first-responder action messages to save, revert, and print their data.

Conceptually, a document is a container for a body of information 
identified by a name under which it is stored in a disk file.

## Subclassing NSDocument

The NSDocument class is designed to be subclassed.

## Document Saving Behavior

NSDocument saving 기능은 파일의 여러 특성을 보존하는 방식으로 동작한다.
생성일, 퍼미션, 파인더 폴더뷰에서 위치, Show Extention 세팅,
그러니 파일 저장을 요청할 때 write...를 불러쓰기 보다는 save...를 불러써야 한다.
write...은 오버라이딩 용이다.
save...는 write...를 사용한 후 이것저것 파일 속성 세팅을 한다.

비슷하게 read...매서드 대신 revert...를 쓴는 것이 낫다.
read...은 오버라이딩 용이다.

## iCloud

The NSDocument class implements the file coordination support
that is required for an iCloud-enabled.




