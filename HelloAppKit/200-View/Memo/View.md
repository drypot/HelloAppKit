
# View

## View Programming Guide for Cocoa

Introduction to View Programming Guide for Cocoa
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaViewsGuide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40002978


## Views and Controls

https://developer.apple.com/documentation/appkit/views-and-controls

NSView is the root class for all views and defines their common behavior. 

NSControl defines additional behaviors 
that are specific to buttons, switches, and other views 
designed for user interactions.


## NSView

https://developer.apple.com/documentation/appkit/nsview

### Handling events in your subclass

If you subclass NSView directly and handle specific types of events,
don’t call super in the implementations of your event-related methods.

Views inherit their event-handling capabilities from their NSResponder parent class.

The default behavior for responders is to pass events up the responder chain,
which isn’t the behavior you typically want for a custom view.
Therefore, don’t call super if your view implements any of the following methods ...

