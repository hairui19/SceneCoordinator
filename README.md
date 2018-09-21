# SceneCoordinator

<p align="left">
<a href="https://swift.org"><img src="https://img.shields.io/badge/swift-v4.0-red.svg"></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/v/Sensitive.svg?maxAge=2592000"></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/dt/Sensitive.svg?maxAge=2592000"></a>
<a href="https://tldrlegal.com/license/mit-license"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat"></a>
</p>

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
### Description
The purpose of SceneCoordinator is to simplify navigation among UIViewControllers in iOS, so that:
* UIViewControllers are isolated from each other
* UIViewControllerDelegates are no longer needed. 
* Navigation codes are reduced as much as down to a single line. 

Examples:
```swift
// Push Operation with data 
SceneCoordinator<Main>.push(to: .firstViewController, withData: ["data" : "FromMain"], animated: true)

// Presen Operation 
SceneCoordinator<PresentNav>.presentNav(with: .navFirstChildViewController, animated: true)

// Pop Operation
SceneCoordinator<Main>.popToPrevious(animated: true)

// Dimiss operation 
SceneCoordinator<Nav>.dismiss(animated: true)

// TabSelection Operation
SceneCoordinator<Tab>.select(1)
```

### Set Up
Setup, ideally an enum, and conform it to `SceneType`
```swift
enum Main{
    case first
}

extension Main : SceneType{
    var storyboard: String {
    }

    var viewControllerType: UIViewController.Type {
    }

    var storyboardBundle: Bundle? {
    }
}
```

Note: you don't have to create `Nav` and `Tab` sceneTypes. They are defined by `SceneCoordinator` framework by default to perform 
- `dismiss` function for `Nav`
- `selectTab` function for `Tab`

### Passing data to present/pushed viewController 
`push` and `present` both have overload functions that accept a data parameter which is in `[String : Any]` format. 

Override `willMoveToInterface` in ViewController to retrieve data from `push`, `present` and `Tab.select` operations.
```swift
override func willMoveToInterface(with data: [String : Any]) {
// `From:` is a framework defined key
// Read the value to know which viewController initiated the navigation
    if let fromViewController = data["From:"]{

    }
    if let data = data["data"] as? String{
        labelContent = data
    }
}
```

Override `willRevealOnInterface` to retrive data from `pop` and `Nav.dismiss` operations.

```swift
override func willRevealOnInterface(with data: [String : Any]) {
    if let data = data["data"] as? String{
        label.text = data
        }
}
```


## Author

linhairui. Email: linhairui19@gmail.com

## License

SceneCoordinator is available under the MIT license. See the LICENSE file for more info.
