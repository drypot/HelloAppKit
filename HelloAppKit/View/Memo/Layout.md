#  Layout

https://www.hackingwithswift.com/articles/140/the-auto-layout-cheat-sheet

## 레이아웃 정책의 역사

### Autoresizing Mask

macOS 초기 (~10.6)
뷰 크기 조절을 단순한 규칙으로 설정 (제약 조건 없음)

    subview.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
### Auto Layout / NSLayoutConstraint

macOS 10.7 (2011)
레이아웃 제약을 수학적 관계로 정의 (제약 기반)

    [NSLayoutConstraint activateConstraints:@[
        [subview.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:20]
        [subview.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor constant:10],
        [subview.trailingAnchor constraintEqualToAnchor:parentView.trailingAnchor constant:-10],
    ]];

### StackView

macOS 10.9 (2013)
뷰의 정렬과 크기 조절을 자동화 (자동 제약 생성)

    NSStackView *stackView = [[NSStackView alloc] init];
    stackView.orientation = NSUserInterfaceLayoutOrientationVertical;
    [stackView addArrangedSubview:subview1];
    [stackView addArrangedSubview:subview2];


## Understanding Auto Layout

https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1
