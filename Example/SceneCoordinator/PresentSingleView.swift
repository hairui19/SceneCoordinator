//
//  PresentSingleView.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SceneCoordinator

enum PresentSingleView{
    
    case presentSingleViewExampleViewController
    case presentSingleFirstViewController
    
}

extension PresentSingleView : SceneType{
    var storyboard: String {
        return "PresentSingleView"
    }
    
    var viewControllerType: UIViewController.Type {
        switch self {
        case .presentSingleViewExampleViewController:
            return PresentSingleViewExampleViewController.self
        case .presentSingleFirstViewController:
            return PresentSingleFirstViewController.self
        }
    }
    
    var storyboardBundle: Bundle? {
        return nil 
    }
    
    
    
    
}
