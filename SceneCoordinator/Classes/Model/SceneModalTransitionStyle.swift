//
//  SceneTransitionStyle.swift
//  ScenesCoordinator
//
//  Created by Hairui on 19/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

public enum SceneModalTransitionStyle : Int{
    case `default`
    case coverVertical
    case flipHorizontal
    case crossDissolve
    @available(iOS 3.2, *)
    case partialCurl
    
    var value : UIModalTransitionStyle{
        switch self {
        case .default:
            return .coverVertical
        case .coverVertical:
            return .coverVertical
        case .flipHorizontal:
            return .flipHorizontal
        case .crossDissolve:
            return .crossDissolve
        case .partialCurl:
            return .partialCurl
        }
    }
}
