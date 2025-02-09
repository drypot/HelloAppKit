#  Table View Programming Guide for Mac

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TableView/Introduction/Introduction.html#//apple_ref/doc/uid/10000026i-CH1-SW1

## About Table Views in OS X Applications

### Tables Can Get Data in Two Ways

Programmatically, by implementing a data source class
or Using Cocoa bindings.

The techniques you use to create and populate a table differ
depending on whether the table is 
NSView based or 
NSCell based.

### NSCell-Based Tables Are Still Supported

In OS X v10.6 and earlier, each table view cell was required to be a subclass of NSCell.
This approach caused limitations when designing complex custom cells, 

NSCell-based tables continue to be supported in OS X v10.7 and later, 
but they’re typically used only to support legacy code. 

In general, you should use NSView-based tables.

The code required to provide individual cells, populate the table view, ... differs depending on the table type. 
You use different Cocoa bindings techniques depending on whether ... NSView-based or NSCell-based table.


## Understanding Table Views

### Most Tables Are Based on NSView

Most tables are NSView based, 
which means that each cell is provided by an NSView subclass, 
often by NSTableCellView (or a subclass). 

Some tables are NSCell based, 
which means that each table cell is based on a subclass of NSCell.

If you’re creating a new app, you want to use NSView-based tables.

### Tables Consist of Several Classes That Work Together

NSTableView
NSTableColumn
NSTableHeaderView

NSTableRowView
NSTableCellView

NSScrollView

### A Table View Needs a Data Source and Should Have a Delegate

NSTableViewDataSource protocol

NSTableViewDelegate protocol

### Columns and Cells Have Identifiers That Make It Easy to Find Them

...

### Table Views Reuse Rows to Increase Speed and Efficiency

...


## Populating a Table View Programmatically

To populate a table view programmatically, 
you must implement the NSTableViewDataSource and 
the NSTableViewDelegate protocols.

    NSTableViewDataSource
        numberOfRowsInTableView:
        
    NSTableViewDelegate
        tableView:viewForTableColumn:row:


## Populating a Table View Using Cocoa Bindings

In an NSView-based table, you bind the table view’s content to the array controller’s 'arrangedObjects'.

애플 문서에서 Cocoa Binding 으로 Table View 를 채우는 예제는 IB 쓰는 경우 밖에 없다.

IB 없이 어떻게 해야하나에 대한 질문들은 보이는데 딱히 명확한 답은 못 찾았다.

Create view based NSTableView programmatically using Bindings in Swift
https://stackoverflow.com/questions/34583638/create-view-based-nstableview-programmatically-using-bindings-in-swift

Is it possible to create a view-based NSTableView purely in code?
https://stackoverflow.com/questions/33992756/is-it-possible-to-create-a-view-based-nstableview-purely-in-code

정확한 답변은 없었지만 일단 적어둔다.

Mastering macOS programming-Packt Publishing (2017)
이 책에 관련 예제가 나오지만 역시나 IB를 쓰고 있다.




