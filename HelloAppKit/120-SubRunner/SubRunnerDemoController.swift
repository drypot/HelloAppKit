//
//  SubRunnerDemoController.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/27/24.
//

import Cocoa

// 수제 라이브러리 대신 AppKit 기본만 쓰기로 한다.
// 나중에 AppKit 가이드 쓸 때나 다른 사람들이 학습용도로 보기엔 이게 나을 듯.
// 파일에 반복적으로 중복된 코드가 나타나도 나중에 한눈에 쭉 읽기 편하게 그대로 두는 것도 괜찮은 듯.

class SubRunnerDemoRunner: SubRunner {
}

class SubRunnerDemoController: NSViewController {

    var subRunnerTypes = [String: SubRunner.Type]()
    
    override func loadView() {
        self.view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)
        
        addStackItems(stackView)

        let padding: CGFloat = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
//            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
//            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
        ])
    }

    private func addStackItems(_ stackView: NSStackView) {

        var constraints: [NSLayoutConstraint] = []

        func addSubRunner(_ subRunnerType: SubRunner.Type) {
            let className = String(subRunnerType.className().split(separator: ".").last!)
            //print(className)
            let buttonTitle = className.dropSuffix("Runner").dropSuffix("Controller").dropSuffix("Demo")
            subRunnerTypes[buttonTitle] = subRunnerType
            addButton(buttonTitle)
        }
        
        func addButton(_ title: String) {
            let button: NSButton = NSButton(title: title, target: self, action: #selector(buttonClicked))
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            constraints.append(contentsOf: [
                button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            ])
        }

        addSubRunner(ViewDemoRunner.self)
        addSubRunner(StackViewDemoRunner.self)
        addSubRunner(ConstraintBuilderDemoRunner.self)
        addSubRunner(TextViewDemoRunner.self)
        addSubRunner(CustomTextViewDemoRunner.self)
        addSubRunner(TableViewDemoRunner.self)
        addSubRunner(GestureRecognizerDemoRunner.self)
        addSubRunner(AnimationDemoRunner.self)

        addSubRunner(SubclassesTestRunner.self)

        //        subclasses(of: SubRunner.self)
        //            .filter {
        //                $0 != DemoListRunner.self
        //            }
        //            .sorted {
        //                $0.className() < $1.className()
        //            }
        //            .forEach(addSubRunner)

        NSLayoutConstraint.activate(constraints)
    }
        
    @objc func buttonClicked(_ sender: NSButton) {
        let subRunnerType = subRunnerTypes[sender.title]!
        subRunnerType.init().run()
    }

}

