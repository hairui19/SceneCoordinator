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
    
    internal static var topViewController : UIViewController{
        return Spider.shared.topMostViewController
    }
    
    public init(){}
    
}



// MARK: Push Functions
extension SceneCoordinator : SceneCoordinatorType{
    
    fileprivate static func initialize(data : [String : Any]?, for viewController : UIViewController){
        if var data = data{
            data[actionSceneKey] = String(describing: type(of: viewController.self))
            viewController.willMoveToInterface(with: data)
        }
    }
    
    fileprivate static func callBack(data : [String : Any]?, to revealingViewController : UIViewController, from outgoingViewController : UIViewController){
        if var data = data{
            data[actionSceneKey] = String(describing: type(of: outgoingViewController.self))
            revealingViewController.willRevealOnInterface(with: data)
        }
    }
    
    
    internal static func create(viewControllerWith scene : T, with data : [String : Any]?)->UIViewController{
        let storyboardID = String(describing: scene.viewControllerType)
        let viewController = UIStoryboard(name: scene.storyboard, bundle: scene.storyboardBundle).instantiateViewController(withIdentifier: storyboardID)
        if let data = data{
            viewController.willMoveToInterface(with: data)
        }
        return viewController
    }
    
}

// MARK: - Pusu Functions
extension SceneCoordinator{
    @discardableResult
    public static func push(to scene : T, animated : Bool)->UIViewController{
        return push(to: scene, with: nil, animated: animated)
    }
    
    @discardableResult
    public static func push(to scene : T, withData data : [String : Any], animated : Bool)->UIViewController{
        return push(to: scene, with: data, animated: animated)
    }
    
    private static func push(to scene : T, with data : [String : Any]? = nil, animated : Bool)->UIViewController{
        let viewController = create(viewControllerWith: scene, with: data)
        topViewController.navigationController?.pushViewController(viewController, animated: true)
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
            if String(describing: type(of: viewController.self)) == String(describing: scene.viewControllerType){
                endVC = viewController
                break
            }
        }
        if endVC == nil {
            SceneCoordinatorError.cantFindTheViewControllerInNavigationControllerStack.execute()
        }
        callBack(data: data, to: endVC, from: topViewController)
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
            callBack(data: data, to: secondTopMostViewController, from: topViewController)
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
            callBack(data: data, to: endVC, from: topViewController)
        }
        return topViewController.navigationController?.popToRootViewController(animated: animated)
    }
}
//
// MARK: - Presentation: Single ViewController
extension SceneCoordinator{
    // ----- present a normal UIViewController
    
    @discardableResult
    public static func present(
        scene : T,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func present(
        scene : T,
        withData data : [String : Any],
        animated : Bool
        )->UIViewController{
        return present(scene: scene, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    public static func present(
        scene : T,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    public static func present(
        scene : T,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        return present(scene: scene, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    private static func present(
        scene : T,
        with data : [String : Any]?,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UIViewController{
        let presentedViewController = create(viewControllerWith: scene, with: data)
        presentedViewController.modalTransitionStyle = transitionStyle.value
        presentedViewController.modalPresentationStyle = presentationStyle.value
        
        topViewController.present(presentedViewController, animated: animated) {
            Spider.shared.addNewInterface(presentedViewController)
        }
        return presentedViewController
    }
}
//
// MARK: - Presentation: NavBar
extension SceneCoordinator{
    // Core Function for Container Presentation
    private static func createNav<U: UINavigationController>(
        with scene : [T],
        in navBarType : U.Type,
        with data: [String : Any]?,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle
        )->U{
        let navBarController = navBarType.init()
        navBarController.modalTransitionStyle = transitionStyle.value
        navBarController.modalPresentationStyle = presentationStyle.value
        navBarController.viewControllers = scene.map { (scene) -> UIViewController in
            return create(viewControllerWith: scene, with: nil)
        }
        if let data = data{
            navBarController.childViewControllers.last?.willMoveToInterface(with: data)
        }
        return navBarController
    }
    
    private static func presentNav<E: UINavigationController>(
        with scene : [T],
        in navBarType : E.Type,
        with data: [String : Any]?,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->E{
        let navBarController = createNav(with: scene, in: navBarType, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle)
        topViewController.present(navBarController, animated: animated) {
            Spider.shared.addNewInterface(navBarController)
        }
        return navBarController
    }
    
    /// Present viewControllers in default UINavigationController
    @discardableResult
    public static func presentNav(
        with scene : T...,
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: UINavigationController.self, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNav(
        with scene : T...,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: UINavigationController.self, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    

    
    /// Present viewControllers in default UINavigationController
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentNav(
        with scene : T...,
        withData data : [String : Any],
        animated : Bool
        )->UINavigationController{
        return presentNav(with: scene, in: UINavigationController.self, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNav(
        with scene : T...,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool
        )->UINavigationController{
        return presentNav(with: scene, in: UINavigationController.self, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined NavigationControllerType
    @discardableResult
    public static func presentNav(
        with scene : T...,
        in navigationControllerType : UINavigationController.Type,
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: navigationControllerType, with: nil, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNav(
        with scene : T...,
        in navigationControllerType : UINavigationController.Type,
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: navigationControllerType, with: nil, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: animated)
    }
    
    /// Present viewControllers in defined NavigationControllerType
    /// Data is passed to the ViewController that is on the screen
    @discardableResult
    public static func presentNav(
        with scene : T...,
        in navigationControllerType : UINavigationController.Type,
        withData data : [String : Any],
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: navigationControllerType, with: data, withTransitionStyle: .default, withPresentationStyle: .default, animated: animated)
    }
    
    @discardableResult
    public static func presentNav(
        with scene : T...,
        in navigationControllerType : UINavigationController.Type,
        withData data : [String : Any],
        withTransitionStyle transitionStyle: SceneModalTransitionStyle,
        withPresentationStyle presentationStyle: SceneModalPresentationStyle,
        animated : Bool)->UINavigationController{
        return presentNav(with: scene, in: navigationControllerType, with: data, withTransitionStyle: transitionStyle, withPresentationStyle: presentationStyle, animated: true)
    }
    
}

// MARK: - TabBar Selection
extension SceneCoordinator where T == Tab{
    // selecting viewController
    private static func select(_ index : Int, with data: [String: Any]?){
        let currentViewControllerName = String(describing: type(of: topViewController.self))
        if var data = data{
            data[actionSceneKey] = String(describing: type(of: topViewController.self))
        }
        topViewController.tabBarController?.selectedIndex = index
        if var data = data{
            data[actionSceneKey] = currentViewControllerName
            topViewController.willRevealOnInterface(with: data)
        }
        return
    }
    
    public static func select(_ index : Int, withData data: [String: Any]){
        select(index, with: data)
    }
    
    public static func select(_ index: Int){
        select(index, with: nil)
    }
    
}

// MARK: -Present & Dismiss
extension SceneCoordinator where T == Nav{
    
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
            callBack(data: data, to: topMostViewController, from: topViewController)
        }
        topViewController.dismiss(animated: animated) {
            Spider.shared.deleteCurrentInterface()
        }
    }
}


