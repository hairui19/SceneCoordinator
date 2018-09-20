//
//  Spider.swift
//  ScenesCoordinator
//
//  Created by Hairui on 18/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

internal class Spider{
    
    internal static let shared = Spider()
    
    var interfaceStack : Stack!
    private var currentInterface : UIViewController!
    
    private init(){
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else{
            fatalError("RootViewController Does Not Exist")
        }
        interfaceStack = Stack()
        interfaceStack.push(rootViewController)
        currentInterface = rootViewController

    }
}

extension Spider{
    var topMostViewController : UIViewController{
        return topViewController(from: currentInterface)
    }
    
    var topMostViewControllerOfPreviousNode : UIViewController?{
        guard let previousNode = interfaceStack.secondTopMostInterface() else{
            return nil
        }
        return topViewController(from: previousNode)
    }
    
    private func topViewController(from viewController : UIViewController)->UIViewController{
        if let tabBarController = viewController as? UITabBarController{
            let selectedViewController = tabBarController.childViewControllers[tabBarController.selectedIndex]
            return topViewController(from: selectedViewController)
        }else if let navBarController = viewController as? UINavigationController{
            guard let topController = navBarController.topViewController else{
                fatalError("The NavBarController does not contain any viewController")
            }
            return topViewController(from:topController)
        }else{
            return viewController
        }
    }
    
    internal func addNewInterface(_ viewController : UIViewController){
        currentInterface = viewController
        interfaceStack.push(viewController)
    }

    @discardableResult
    internal func deleteCurrentInterface()->UIViewController?{
        let popedInterface = interfaceStack.pop()
        currentInterface = interfaceStack.topMostInterface
        return popedInterface
    }
}
