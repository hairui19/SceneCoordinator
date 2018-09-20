//
//  ScenePresentationStyle.swift
//  ScenesCoordinator
//
//  Created by Hairui on 19/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

public enum SceneModalPresentationStyle{
    case `default`
    case fullScreen
    
    @available(iOS 3.2, *)
    case pageSheet
    
    @available(iOS 3.2, *)
    case formSheet
    
    @available(iOS 3.2, *)
    case currentContext
    
    @available(iOS 7.0, *)
    case custom
    
    @available(iOS 8.0, *)
    case overFullScreen
    
    @available(iOS 8.0, *)
    case overCurrentContext
    
    @available(iOS 8.0, *)
    case popover
    
    case none
    
    
    var value : UIModalPresentationStyle{
        switch self {
        case .default:
            return .fullScreen
        case .fullScreen:
            return .fullScreen
        case .pageSheet:
            return .pageSheet
        case .formSheet:
            return .formSheet
        case .currentContext:
            return .currentContext
        case .custom:
            return .custom
        case .overFullScreen:
            return .overFullScreen
        case .overCurrentContext:
            return .overCurrentContext
        case .popover:
            return .popover
        case .none:
            return .none
        }
    }
}
