//
//  SceneCoordinatorError.swift
//  ScenesCoordinator
//
//  Created by Hairui on 19/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import Foundation

public enum SceneCoordinatorError{

    case ViewControllerIsNotEmbeddedInNavigationController
    case cantFindTheViewControllerInNavigationControllerStack
    
    
    func execute(){
        switch self {
        case .ViewControllerIsNotEmbeddedInNavigationController:
            fatalError("The viewController is not embedded in a navigationController")
        case .cantFindTheViewControllerInNavigationControllerStack:
            fatalError("Cannot find the viewController in the navigationController stack")
        }
    }
}
