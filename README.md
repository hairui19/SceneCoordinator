# SceneCoordinator

[![CI Status](https://img.shields.io/travis/linhairui19@gmail.com/SceneCoordinator.svg?style=flat)](https://travis-ci.org/linhairui19@gmail.com/SceneCoordinator)
[![Version](https://img.shields.io/cocoapods/v/SceneCoordinator.svg?style=flat)](https://cocoapods.org/pods/SceneCoordinator)
[![License](https://img.shields.io/cocoapods/l/SceneCoordinator.svg?style=flat)](https://cocoapods.org/pods/SceneCoordinator)
[![Platform](https://img.shields.io/cocoapods/p/SceneCoordinator.svg?style=flat)](https://cocoapods.org/pods/SceneCoordinator)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 10.0 and later
* Xcode 9.0 and later
* Swift 4.0

## Installation

SceneCoordinator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SceneCoordinator'
```

## Usage
```swift
    SceneCoordinator<Main>.push(to: .firstViewController, withData: ["data" : "FromMain"], animated: true)
```

### Coordinating between views
```swift

```

### Coordinating between views

All gestures are available via special variables that you can call on any `UIView` instance. Examples:

```swift

```

Full list of available gestures:

- `onTap`
- `onLongPress`
- `onPan`
- `onPinch`
- `onRotation`
- `onSwipe`
- `onScreenEdgePan`


## Author

linhairui. Email: linhairui19@gmail.com

## License

SceneCoordinator is available under the MIT license. See the LICENSE file for more info.
