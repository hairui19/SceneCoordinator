//
//  SceneType.swift
//  ScenesCoordinator
//
//  Created by Hairui on 17/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

/// Protocol for specifying the minimum requirement for `Scene`
public protocol SceneType{
    
    /// Name of the storyboard (without .storyboard) at which the viewController is.
    /// - Eg, "Main.storyboard" -> "Main"
    var storyboard : String {get}
    
    /// ViewController Type
    /// Eg. MainViewController.self
    var viewControllerType : UIViewController.Type { get }
    
    /// Bundle which contains the storyboard files and its related resources
    var storyboardBundle : Bundle? {get}
    
    /// ViewController Class Type
//    var type : class {get}

}


/// NavigationController placeholder type for dismiss function
public enum Nav : SceneType{
    public var storyboard: String{
        return ""
    }
    
    public var viewControllerType: UIViewController.Type{
        return UIViewController.self
    }
    
    public var storyboardBundle: Bundle?{
        return nil
    }
}

/// TabBarController placeholder type for selection function
public enum Tab : SceneType{
    public var storyboard: String{
        return ""
    }
    
    public var viewControllerType: UIViewController.Type{
        return UIViewController.self
    }
    
    public var storyboardBundle: Bundle?{
        return nil
    }
}
