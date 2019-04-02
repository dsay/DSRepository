# Repository

## Description      
The simplest approach, especially with an existing system, is to create a new Repository implementation for each business object you need to store to or retrieve from your persistence layer. Further, you should only implement the specific methods you are calling in your application. Avoid the trap of creating a “standard” repository class, base class, or default interface that you must implement for all repositories. Yes, if you need to have an Update or a Delete method, you should strive to make its interface consistent (does Delete take an ID, or does it take the object itself?), but don’t implement a Delete method on your LookupTableRepository that you’re only ever going to be calling List() on. The biggest benefit of this approach is YAGNI – you won’t waste any time implementing methods that never get called.


## Requirements

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build.

To integrate Repository into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'Repository', :git => 'https://github.com/dsay/Repository.git', :tag => '0.1.0'
end
```

Then, run the following command:

```bash
$ pod install
```

**Demo App**

- [Example]()


## Author

Dima Sai , dmitriy.sai2013@gmail.com

## License

Repository is available under the MIT license. See the LICENSE file for more info.
