# Introduction #

This section contains [utility components](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Dictionary) for using with [NSDictionary](http://developer.apple.com/library/mac/#documentation/cocoa/reference/foundation/classes/nsdictionary_class/Reference/Reference.html) class.


# Details #

Components in this section include:
  * [OxICDictionaryConverter](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Dictionary/OxICDictionaryConverter.m), which reads properties from an object and copies it recursively into dictionaries. It relies on [class wrapper](http://code.google.com/p/oxeniphonecommons/source/browse/#svn%2Ftrunk%2Fmain%2FClasses%2FWrapper) in order to acces and enumerate properties. The only restriction is that the object can't contain cyclic references.
  * [OxICDictionaryProxy](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Dictionary/OxICDictionaryProxy.m), which allows accessing a dictionary through standar "setter/getter" methods in a protocol/class.

Both components have a boolean property:
  * capitalizeFields: Converts first letter in field names to uppercase. This property can be helpful if your data uses Pascal case convention (for example, data coming from a .NET service).