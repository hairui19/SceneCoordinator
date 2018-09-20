//
//  ScenesCoordinator.swift
//  ScenesCoordinator
//
//  Created by Hairui on 17/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

public class SceneCoordinator<T : SceneType>{
    public typealias sceneType = T
    
    public static var actionSceneKey : String{
        return "From:"
    }
    
    private static var topViewController : UIViewController{
        return Spider.shared.topMostViewController
    }
    
    public init(){}
    
}

// MARK: Push Functions
extension SceneCoordinator : SceneCoordinatorType{
    
    private static func instantiateViewController(with scene : T)->UIViewController{
        return UIStoryboard(name: scene.storyboard, bundle: scene.storyboardBundle).instantiateViewController(withIdentifier: scene.storyboardID)
    }
    
    private static func initialize(data : [String : Any]?, for viewController : UIViewController){
        if var data = data{
            data[actionSceneKey] = String(describing: type(of: viewController.self))
            viewController.willMoveToInterface(with: data)
        }
    }
    
    private static func callBack(data : [String : Any]?, for viewController : UIViewController){
        if var data = data{
            data[actionSceneKey] = String(describing: type(of: viewController.self))
            viewController.willRevealOnInterface(with: data)
        }
    }
    
    
    @discardableResult
    public static func push(to scene : T, animated : Bool)->UIViewController{
        return push(to: scene, with: nil, animated: animated)
    }
    
    @discardableResult
    public static func push(to scene : T, withData data : [String : Any], animated : Bool)->UIViewController{
        return push(to: scene, with: data, animated: animated)
    }
    
    private static func push(to scene : T, with data : [String : Any]? = nil, animated : Bool)->UIViewController{
        let viewController = instantiateViewController(with: scene)
        initialize(data: data, for: viewController)
        topViewController.navigationController?.pushViewController(viewController, animated: animated)
        return viewController
    }
}

// MARK: - Pop Functions
extension SceneCoordinator{
    // ---- Pop Functions
    @discardableResult
    public static func pop(to scene : T, animated : Bool)->[UIViewController]?{
        return pop(to: scene, with: nil, animated: animated)
    }
    
    @discardableResult
    public static func pop(to scene : T, withData data: [String : Any], animated : Bool)->[UIViewController]?{
        return pop(to: scene, with: data, animated: animated)
    }
    
    private static func pop(to scene : T, with data: [String : Any]? = nil, animated : Bool)->[UIViewController]?{
        guard let navBarController = topViewController.navigationController else{
            SceneCoordinatorError.ViewControllerIsNotEmbeddedInNavigationController.execute()
            return nil
        }
        
        var endVC : UIViewController!
        for viewController in navBarController.childViewControllers.reversed(){
            if String(describing: type(of: viewController.self)) == scene.storyboardID{
                endVC = viewController
                break
            }
        }
        if endVC == nil {
            SceneCoordinatorError.cantFindTheViewControllerInNavigationControllerStack.execute()
        }
        callBack(data: data, for: endVC)
        return topViewController.navigationController?.popToViewController(endVC, animated: animated)
    }
    
    // ---- PopToPrevious Functions
    @discardableResult
    public static func popToPrevious(animated : Bool = true)->UIViewController?{
        return popToPrevious(with: nil, animated: animated)
    }
    
    @discardableResult
    public static func popToPrevious(withData data : [String : Any], animated : Bool)->UIViewController?{
        return popToPrevious(with: data, animated: animated)
    }
    
    private static func popToPrevious(with data: [String : Any]? = nil, animated : Bool)->UIViewController?{
        if let data = data{
            guard let navBarController = topViewController.navigationController else{
                SceneCoordinatorError.ViewControllerIsNotEmbeddedInNavigationController.execute()
                return nil 
            }
            let secondTopMostViewController = navBarController.childViewControllers[navBarController.childViewControllers.count - 2]
            callBack(data: data, for: secondTopMostViewController)
        }
        return topViewController.navigationController?.popViewController(animated: animated)
    }
    
    // ------ PopToRoot Functions
    @discardableResult
    public static func popToRoot(animated : Bool)->[UIViewController]?{
        return popToRoot(with: nil, animated: animated)
    }
    
    @discardableResult
    public static func popToRoot(withData data : [String : Any], animated: Bool)->[UIViewController]?{
        return popToRoot(with: data, animated: animated)
    }
    
    private static func popToRoot(with data : [String : Any]? = nil, animated : Bool)->[UIViewController]?{
        if let data = data{
            guard let navBarController = topViewController.navigationController else{
                SceneCoordinatorError.ViewControllerIsNotEmbeddedInNavigationController.execute()
                return nil
            }
            let endVC = navBarController.childViewControllers[0]
            callBack(data: data, for: endVC)
        }
        return topViewController.navigationController?.popToRootViewController(animated: animated)
    }
}

// MARK: - Presentation: Single ViewController
extension SceneCoordinator{
    // ----- present a normal UIViewController
    
    @discardableResult
    public static func present(
        scene : T,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, withData: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func present(
        scene : T,
        withData data : Any,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, withData: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    public static func present(
        scene : T,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, withData: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    public static func present(
        scene : T,
        withData data : Any,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, withData: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    private static func present(
        scene : T,
        withData data : [String : Any]?,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        let presentedViewController = instantiateViewController(with: scene)
        presentedViewController.modalTransitionStyle = transitionStyle.value
        presentedViewController.modalPresentationStyle = presentationStyle.value
        
        topViewController.present(presentedViewController, animated: animated) {
            Spider.shared.addNewInterface(presentedViewController)
        }
        return presentedViewController
    }
}

// MARK: - Presentation: NavBar
extension SceneCoordinator{
    // Core Function for Container Presentation
    private static func present<U : UIViewController>(
        scene : [T],
        in containerType : U.Type,
        selectedIndex : Int,
        with data : [String : Any]?,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->U{
        
        let containerController = containerType.init()
        containerController.modalTransitionStyle = transitionStyle.value
        containerController.modalPresentationStyle = presentationStyle.value
        
        let childViewControllers = scene.map { (scene) -> UIViewController in
            return instantiateViewController(with: scene)
        }
        
        if let navBarController = containerController as? UINavigationController{
            navBarController.viewControllers = childViewControllers
            initialize(data: data, for: childViewControllers.last!)
        }else if let tabBarController = containerController as? UITabBarController{
            tabBarController.viewControllers = childViewControllers
            tabBarController.selectedIndex = selectedIndex
            initialize(data: data, for: childViewControllers[selectedIndex])
        }
        
        topViewController.present(containerController, animated: animated) {
            Spider.shared.addNewInterface(containerController)
        }
        return containerController
    }
    
    /// Present viewControllers in default UINavigationController
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: UINavigationController.self, selectedIndex: 0, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: UINavigationController.self, selectedIndex: 0, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    

    
    /// Present viewControllers in default UINavigationController
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        withData data : [String : Any],
        animated : Bool
        )->UINavigationController{
        return present(scene: scene, in: UINavigationController.self, selectedIndex: 0, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UINavigationController{
        return present(scene: scene, in: UINavigationController.self, selectedIndex: 0, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined NavigationControllerType
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        in containerType : UINavigationController.Type,
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        in containerType : UINavigationController.Type,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined NavigationControllerType
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        in containerType : UINavigationController.Type,
        withData data : [String : Any],
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNavBar(
        with scene : T...,
        in containerType : UINavigationController.Type,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
}

// MARK: - Presentation: TabBar
extension SceneCoordinator{
    // ---- presentInTabBar
    /// Present viewControllers in default UITabBarController
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: 0, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        selected index : Int,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: index, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: 0, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        selectedIndex index : Int,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: index, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    
    
    /// Present viewControllers in default UITabBarController
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        withData data : [String : Any],
        animated : Bool
        )->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: 0, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        withData data : [String : Any],
        selectedIndex index : Int,
        animated : Bool
        )->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: index, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: 0, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        withData data : [String : Any],
        selectedIndex index : Int,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UITabBarController{
        return present(scene: scene, in: UITabBarController.self, selectedIndex: index, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined UITabBarController
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        selectedIndex index : Int,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: index, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        selectedIndex index : Int,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: index, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined UITabBarController
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        withData data : [String : Any],
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        withData data : [String : Any],
        selectedIndex index : Int,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: index, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: 0, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    @discardableResult
    public static func presentTabBar(
        with scene : T...,
        in containerType : UITabBarController.Type,
        withData data : [String : Any],
        selectedIndex index : Int,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UITabBarController{
        return present(scene: scene, in: containerType.self, selectedIndex: index, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
}

// MARK: -Present & Dismiss
extension SceneCoordinator{
    
    public static func dismiss(animated : Bool){
        dismiss(with: nil, animated: true)
    }
    
    /// The data is passed to the topMostViewController of the revealing interface
    public static func dismiss(withData data : [String : Any], animated : Bool){
        dismiss(with: data, animated: true)
    }
    
    private static func dismiss(with data : [String : Any]?, animated : Bool){
        if let data = data{
            guard let topMostViewController = Spider.shared.topMostViewControllerOfPreviousNode else{
                return
            }
            callBack(data: data, for: topMostViewController)
        }
        topViewController.dismiss(animated: animated) {
            Spider.shared.deleteCurrentInterface()
        }
    }
}

