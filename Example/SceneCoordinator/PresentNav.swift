//
//  PresentNav.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SceneCoordinator

enum PresentNav{
    
    case presentNavExampleViewController
    case navFirstChildViewController
    case navSecondChildViewController
    
}

extension PresentNav : SceneType{
    var storyboard: String {
        return "PresentNav"
    }
    
    var viewControllerType: UIViewController.Type {
        switch self {
        case .presentNavExampleViewController:
            return PresentNavExampleViewController.self
        case .navFirstChildViewController:
            return NavFirstChildViewController.self
        case .navSecondChildViewController:
            return NavSecondChildViewController.self
        }
    }
    
    var storyboardBundle: Bundle? {
        return nil 
    }
    
    
}
