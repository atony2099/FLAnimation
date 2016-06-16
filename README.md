#FLAnimation

## About
Easy way to shake or scale the view with animation

![](example.gif)

## Using
##### animate With default parameters 
```objective-c
[button shakeHorizontal];
``` 
##### animatie with call-back
```objective-c
[button shakeHorizontalWithCompletionBlock:^{
    NSLog(@"call-back");
}];

```
##### animatie with  call-back and duration
```objective-c
[button shakeHorizontalWithDuration:3.f CompletionBlock:^{
    NSLog(@"call-back");
}];
```

## Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFViewShaker in your projects.  

##### Podfile
```ruby
pod "FLAnimation"
```

##License:  
FLCorner is released under the MIT license. See LICENSE for details.