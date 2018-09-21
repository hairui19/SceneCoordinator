# SceneCoordinator

<p align="left">
<a href="https://swift.org"><img src="https://img.shields.io/badge/swift-v4.0-red.svg"></a>
<a href="https://cocoapods.org"><img src="https://img.shields.io/badge/pod-v0.1.0%20(beta)-orange.svg"></a>
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
SceneCoordinator<Main>.push(to: .firstViewController, animated: true)

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
Setup, ideally an enum, and conform it to `SceneType` :

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
**_Note1: you don't have to create `Nav` and `Tab` sceneTypes. They are defined by `SceneCoordinator` framework by default to perform_**
- `dismiss` function for `Nav`
- `selectTab` function for `Tab`

**_Note2: The framework gets the UIViewControllers from storyboard via their IDs, so please name every UIViewController's storyboardID the same as the class name_**
<img width="256" alt="screen shot 2018-09-21 at 4 21 20 pm" src="https://user-images.githubusercontent.com/24172260/45869353-d6cb1400-bdba-11e8-9977-2e4f58cf3392.png">


### Passing Data
`push`, `present` and `Tab.select` all have overload functions that accept a data parameter which is in `[String : Any]` format. 
```swift
// push
SceneCoordinator<Main>.push(to: .firstViewController, withData: ["data" : "FromMain"], animated: true)

// present
SceneCoordinator<PresentSingleView>.presentView(scene: .presentSingleFirstViewController, withData: ["data" : text], animated: true)

// Tab.select
SceneCoordinator<Tab>.select(2, withData: ["push" : true])
```

### Retrieving Data
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

### Full list of operations:

- `push`
- `pop`
- `present`
- `presentNav` (viewControllers will be embeded in the type of UINavigationController specified)
- `dismiss` (only available through `SceneCoordinator<Nav>`)
- `select` (only available through `SceneCoordinator<Tab>`)


## Author

linhairui. Email: linhairui19@gmail.com

## License

SceneCoordinator is available under the MIT license. See the LICENSE file for more info.
