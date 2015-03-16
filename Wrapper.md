# Introduction #
Documentation for [Wrapper component](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Wrapper/).

# Details #
The [Wrapper component](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Wrapper/) allows wrapping of classes and objects in order to manipulate them in a dynamic way.

The implementation is hidden behind a [WrapperFactory](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Wrapper/API/OxICWrapperFactory.h).

A [simple implementation](http://code.google.com/p/oxeniphonecommons/source/browse/trunk/main/Classes/Wrapper/Impl/Simple/) is provided.

The interface style is taken from [Spring Bean Wrapper](http://static.springsource.org/spring/docs/3.0.5.RELEASE/reference/validation.html).

# Ideas #
  * Provide a more sophisticated implementation with chained property access (using dot in property name). Maybe it works, since current implementation uses key-value coding.