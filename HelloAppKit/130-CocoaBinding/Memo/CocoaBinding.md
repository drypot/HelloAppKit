#  Cocoa Binding

https://developer.apple.com/documentation/appkit/cocoa-bindings

Cocoa Bindings Programming Topics
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/CocoaBindings.html

## What Is a Binding?

A binding is an attribute of one object that may be bound to a property in another.
For example, the “value” binding of a text field 
might be bound to the temperature attribute of a particular model object.

a binding specifies the key path to a property to which a given attribute is bound.

Cocoa bindings uses prebuilt controller objects (subclasses of NSController) 
and supporting technologies 
to keep values synchronized automatically.

## Extending the MVC Design Pattern

The Cocoa bindings architecture extends the traditional Cocoa MVC configuration, 
where there is a single custom-built controller that manages the user interface. 

It provides a set of reusable controller classes 
that inherit from an abstract superclass, NSController.

## Supporting Technologies

Cocoa bindings rely primarily on two other technologies, 
key-value coding (KVC) and 
key-value observing (KVO).

### Key-Value Binding

    @objc dynamic var sliderValue = 50.0
    let slider = NSSlider(value: 50.0, minValue: 0.0, maxValue: 100.0, target: nil, action: nil)

    ...
    slider.bind(.value, to: self, withKeyPath: #keyPath(sliderValue), options: nil)

위 처럼 View 에 bind(_:to:withKeyPath:options:) 메지시를 보내서 바인딩을 만든다.

바인딩은 양방향이다.
뷰를 업데이트하면 연결된 프로퍼티가 바뀌고 프로퍼티를 업데이트하면 뷰가 업데이트된다.

View 는 NSObjectController.content 를 업데이트하고
NSObjectCongtroller는 Model을 업데이트한다.
View 에서 시발된 업데이트는 Key-Value Coding 을 사용해 컨트롤러와 Model을 업데이트한다.

Model에서 시발된 업데이트는 Key-Value Observing 을 사용해 컨트롤러와 View를 업데이트한다.

## Key-Value Coding

    class BankAccount: NSObject {
        @objc var balance: Double // KVC 에서는 dynamic 이 없어도 된다.
        ...
    }

    let account = BankAccount(balance: 1000.0)

    account.setValue(1600.0, forKey: "balance")

## Key-Value Observing

    class BankAccount: NSObject {
        @objc dynamic var balance: Double // KVO 에서는 dynamic 이 필요하다.
        ...
    }

    let account = BankAccount(balance: 1000.0)

    let observation = account.observe(\.balance, options: [.old, .new]) { account, change in
        if let oldValue = change.oldValue, let newValue = change.newValue {
            logger.append("changed from \(oldValue) to \(newValue)")
        }
    }

    account.balance += 500.0 // This will trigger the observation

    // Cleanup
    observation.invalidate()

관찰 대상 프로퍼티가 변경되면 NSNotificationCenter를 통해서 핸들링 클러져를 호출한다.

Cocoa 에서는 Model property 에서 NSObjectController에 노티하고 컨트롤러가 각 View에 노티한다.

## Why Are NSControllers Useful?

Bindings can, in principle, be made between almost any two objects, 
provided that they are KVC-compliant and KVO-compliant. 

A view could bind directly to a model object. 

Bindings-based applications, however, use controller objects 
to manage individual model objects and collections of model objects and 
to interface to the user preferences system.

NSController instances manage their current selection and placeholder values.

NSController implements the NSEditor and NSEditorRegistration protocols.
The NSEditorRegistration protocol provides a means for an editor (a view) 
to inform a controller when it has uncommitted changes.

## NSController Classes

NSController is an abstract class. 

Its concrete subclasses are 

NSObjectController, 
NSUserDefaultsController, 
NSArrayController, and 
NSTreeController.
