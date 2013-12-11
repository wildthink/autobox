#autobox
=======
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

Some Rights Reserved - 2013, WildThink, LLC, Jason Jobe

### Overview
Dustin Bachrach has [contirbuted](https://github.com/dbachrach/OCUDL) a really cool solution for User Defined Literals for Objective-C and inspired me to have a go at a related mechanism, namely autoboxing.

Boxing is a mechanism to coerce values into Objective-C objects that can be applied to symbols as well as literals. The term "autoboxing" is used to refer to a common syntax which creates an appropriate object for a given literal or expression.

### Objective-C Boxed Expressions
Objective-C supports a "boxing" of not only C literals but also of expressions;

see

<http://clang.llvm.org/docs/ObjectiveCLiterals.html>

<http://llvm.org/viewvc/llvm-project/cfe/trunk/lib/AST/NSAPI.cpp?view=markup>

	int i = 23;
	char *cstr = "A c-string";
	
	NSNumber *num = @(i);
	num = @(i + 27);
	NSString *str = @(cstr);
	NSString *another_str = @("Hello World");

But annoyingly, autoboxing an `id`, `nil`, or other ObjC instance results in a compile time error ("Illegal type 'id' used in box expression"). It only works on basic literals and is not extensible.

In short, the standard system falls short on a number of points.

* You can't box Objective C objects - trying to do so is a compile time error.
* nil and Nil are equally unacceptable to @(…).
* Structures are not supported
* It isn't user extensible.


### Autoboxing - new and improved
So what can we do? We wish we could do this.

	NSRect rect = NSZeroRect;
	NSValue *value = @(rect);  // [NSValue valueWithRect:rect]
	id boxedNil = @(nil);		// [NSNull null]
	id anObject = @(value);		// value unaltered

Sadly this sort of thing isn't supported.

But there is a way.

One of the interesting features of the LLVM clang is its support of overloading of functions with a compiler attribute (but without requiring C++). With it we can provide multiple autoboxing functions relying on the compiler overload resolution to dispatch the call the desired one.

	#define overload __attribute__((overloadable))
	
	static inline NSValue* overload autobox(NSRect rect) { 
		return [NSValue valueWithRect:rect];
	}

	static inline id overload autobox(id anyObject) {
		return (anyObject == nil ? [NSNull null] : anyObject);
	}

	NSRect rect = NSZeroRect;
	NSValue *value = autobox(rect);
	id boxedNil = autobox(nil);
	id anObject = autobox(value);

We can add in the $(…) and overload macro to make it succient syntax. And provide our own Autobox Class to give us a hook into the construction of said objects are we are off and running. This just works with typedefs (like enums) as we would expect.
	
	#define $(...) autobox(__VA_ARGS__)
	#define overload __attribute__((overloadable))
	
	typedef enum : unsigned char { Red, Green, Blue } Color;

	NSColor* overload autobox(Color color) { 
		return [[Autobox sharedInstance] valueForColor:color];
	}

	NSValue* overload autobox(NSRect rect) { 
		return [[Autobox sharedInstance] valueWithRect:rect];
	}

	id overload autobox(id anyObject) {
		return (anyObject == nil ?
			[[Autobox sharedInstance] nilObject] : anyObject);
	}

	NSRect rect = NSZeroRect;
	NSValue *value = $(rect);
	NSColor *color = $(Red);
	id boxedNil = $(nil);
	id anObject = $(value);


By using the varadic macro form we can even add optional annotations if we like. For example we could easily introduce units in this way.

	id overload autobox(NSInteger val) { 
		return [[Autobox sharedInstance] valueWithInteger:val];
	}

	id overload autobox(NSInteger val, const char *unit) { 
		return [[Autobox sharedInstance]
				valueWithInteger:val unit:unit];
	}

	NSInteger ivalue = 26;
	
	NSNumber * number = $(ivalue);
	UnitValue *unit_value = $(ivalue, "ft");

### Kudos
A nod to some (of many) that contribute to the community and have inspired work herein.

[OCUDL In Depth](http://www.dbachrach.com/posts/ocudl-in-depth/) by Dustin Bachrach

[Justin Spahr-Summers - libextobjc](https://github.com/jspahrsummers/libextobjc)

