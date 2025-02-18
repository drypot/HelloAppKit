#  Cocoa Binding

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

위는 slider 뷰에 바인딩을 설정하는 예.
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

전통적인 KVO 방식에서는 addObserver 로 옵저버를 등록한다.
Obj C 시절 쓰던 방식이라 여러가지로 불안전하고 불편하다.

Swift 4 이후의 블록 기반 KVO가 도입되었다.
addObserver 대신 observe 메서드를 사용한다.
타입 안정성이 좋고, 옵저버도 자동 제거된다.

observed object 는 observer 에게 바로 변경사항을 보낸다.
알림을 위한 NSNotificationCenter 같은 독립 개체가 없다.

Cocoa 에서는 Model property 에서 NSObjectController에 노티하고
컨트롤러가 각 View에 노티한다.

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

## Key-Value Binding 구현은 어떻게 되는가

How Do Bindings Work?
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/HowDoBindingsWork.html#//apple_ref/doc/uid/20002373-CJBEJBHH

    @interface Joystick : NSView
    {
        float angle;
        id observedObjectForAngle;
        NSString *observedKeyPathForAngle;
        NSValueTransformer *angleValueTransformer;
        // ...
    }

    [joystick bind:@"angle" toObject:GraphicController withKeyPath:@"selection.shadowAngle" options:options];

위는 joystack View 에 바딩인을 설정하는 예.

bind: 메서드에서는 바인딩할 타겟 오브젝트와 프로퍼티 키패스를 저장한다.
바인딩할 키패스에 대한 옵저버를 타겟 오브젝트에 등록한다.

예로

    - (void)bind:(NSString *)binding
     toObject:(id)observableObject
     withKeyPath:(NSString *)keyPath
     options:(NSDictionary *)options
    {
     // Observe the observableObject for changes -- note, pass binding identifier
     // as the context, so you get that back in observeValueForKeyPath:...
     // This way you can easily determine what needs to be updated.
     
        if ([binding isEqualToString:@"angle"])
         {
            [observableObject addObserver:self
                           forKeyPath:keyPath
                          options:0
                          context:AngleBindingContext];
         
            // Register what object and what keypath are
            // associated with this binding
            observedObjectForAngle = [observableObject retain];
            observedKeyPathForAngle = [keyPath copy];
         
            // Record the value transformer, if there is one
            angleValueTransformer = nil;
            NSString *vtName = [options objectForKey:@"NSValueTransformerName"];
            if (vtName != nil)
            {
                angleValueTransformer = [NSValueTransformer
                    valueTransformerForName:vtName];
            }
         }
         
         // Implementation continues...

뷰에 마우스 이벤트가 발생하면 setValue: 를 사용해 아래처럼 변경된 값을 바인딩된 오브젝트에 적용한다. 

    -(void)updateForMouseEvent:(NSEvent *)event
    {
        float newAngleDegrees;
        // calculate newAngleDegrees...
     
        [self setAngle:newAngleDegrees];
     
        if (observedObjectForAngle != nil)
        {
            NSNumber *newControllerAngle = nil;
     
            if (angleValueTransformer != nil)
            {
                newControllerAngle =
                    [angleValueTransformer reverseTransformedValue:
                        [NSNumber numberWithFloat:newAngleDegrees]];
            }
            else
            {
                newControllerAngle = [NSNumber numberWithFloat:newAngleDegrees];
            }
            [observedObjectForAngle setValue: newControllerAngle
                      forKeyPath: observedKeyPathForAngle];
        }
        
        // ...
        
바인딩된 모델에서 값이 바뀌면 옵저버의 observeValueForKeyPath:..change: 메서드를 실행시킨다.

   - (void)observeValueForKeyPath:(NSString *)keyPath
              ofObject:(id)object
            change:(NSDictionary *)change
               context:(void *)context
    {
        // You passed the binding identifier as the context when registering
        // as an observer--use that to decide what to update...
     
        if (context == AngleObservationContext)
        {
            id newAngle = [observedObjectForAngle
                valueForKeyPath:observedKeyPathForAngle];
            if ((newAngle == NSNoSelectionMarker) ||
                (newAngle == NSNotApplicableMarker) ||
                (newAngle == NSMultipleValuesMarker))
            {
                badSelectionForAngle = YES;
            }
            else
            {
                badSelectionForAngle = NO;
                if (angleValueTransformer != nil)
                {
                    newAngle = [angleValueTransformer
                        transformedValue:newAngle];
                }
                [self setValue:newAngle forKey:@"angle"];
            }
        }
        // ...
     
        [self setNeedsDisplay:YES];

애플 문서의 위 예를 보면
간단한 바인딩의 경우 컨트롤러 필요없는 것 같다.
모델과 뷰간 직격 연결해서 쓰는 듯.

## Providing Controller Content

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaBindings/Concepts/CntrlContent.html#//apple_ref/doc/uid/TP40002147-BCICADHC


