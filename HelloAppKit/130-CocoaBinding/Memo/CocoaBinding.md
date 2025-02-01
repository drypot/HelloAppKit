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


## NSController Classes

NSController is an abstract class. 

Its concrete subclasses are 

NSObjectController, 
NSUserDefaultsController, 
NSArrayController, and 
NSTreeController.


