//
//  Main.swift
//  SceneCoordinatorExample
//
//  Created by Hairui on 20/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import Foundation
import SceneCoordinator

enum Main{
    case mainViewController
    case firstViewController
    case secondViewController
    case thirdViewController
    case fourthViewController
    case tabTwoPushedViewController
}

extension Main : SceneType{
    var storyboard: String {
        return "Main"
    }
    
    
    var storyboardBundle: Bundle? {
        return nil 
    }
    
    var viewControllerType : UIViewController.Type{
        switch self{
        case .mainViewController:
            return MainViewController.self
        case .firstViewController:
            return FirstViewController.self
        case .secondViewController:
            return SecondViewController.self
        case .thirdViewController:
            return ThirdViewController.self
        case .fourthViewController:
            return FourthViewController.self
        case .tabTwoPushedViewController:
            return TabTwoPushedViewController.self
        }
    }
    
    
}
