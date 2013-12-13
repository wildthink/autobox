#autobox
=======
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.

Some Rights Reserved - 2013, WildThink, LLC, Jason Jobe

### Overview
The term "autoboxing" refers to a common syntax for constructing an object from a given literal or expression.  In the case of this library, autoboxing refers to coercing non-object types into Objective-C objects.

### Standard Objective-C Boxed Expressions
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

Unforuntatly, autoboxing an `id`, `nil`, or other ObjC instance results in a compile time error ("Illegal type 'id' used in box expression"). This is because the builtin autoboxing only functions on basic literals.

In short, the standard system is deficient in several areas.

* You can't box Objective-C objects - trying to do so is a compile time error.
* nil and Nil are equally unacceptable to @(…).
* Structures are not supported.
* It isn't user extensible.


### Autoboxing - new and improved
What is desired is something akin to the following:

	NSRect rect = NSZeroRect;
	NSValue *value = @(rect);  // [NSValue valueWithRect:rect]
	id boxedNil = @(nil);		// [NSNull null]
	id anObject = @(value);		// value unaltered

Sadly this behaviour isn't supported.

Fortunatly, there is a way.

One of the interesting features of LLVM clang is its support for overloading functions with a compiler attribute (but without requiring C++). With it we can provide multiple autoboxing functions relying on the compilers overload resolution to dispatch the call correctly.

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

The $(…) and overload macro are supplied to make the syntax more succinct.  Internally, they help provide the Autobox Class a way to generate hooks into the construction of said objects.
	
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


By using the variadic macro form we can additionally add optional annotations. For example, we could easily introduce units in this way.

	typedef enum : unsigned char { feet, inch, meter, centimeter } SIUnit;

	id overload autobox(NSInteger val) { 
		return [[Autobox sharedInstance] valueWithInteger:val];
	}

	id overload autobox(NSInteger val, SIUnit unit) { 
		return [[Autobox sharedInstance]
						valueWithInteger:val unit:unit];
	}

	NSInteger ivalue = 26;
	
	NSNumber * number = $(ivalue);
	UnitValue *unit_value = $(ivalue, feet);

### Kudos
A nod to some (of many) that contribute to the community and have inspired work herein.

Thanks to [Henry Stratmann](https://github.com/zippers) for encouraging me to refactor and release this library to the community.

[OCUDL In Depth](http://www.dbachrach.com/posts/ocudl-in-depth/) by Dustin Bachrach.  His work on [User Defined Literals for Objective-C](https://github.com/dbachrach/OCUDL) inspired me to develop this library. 

[Justin Spahr-Summers - libextobjc](https://github.com/jspahrsummers/libextobjc)



