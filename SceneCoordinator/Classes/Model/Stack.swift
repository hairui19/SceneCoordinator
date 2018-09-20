//
//  Stack.swift
//  ScenesCoordinator
//
//  Created by Hairui on 18/9/18.
//  Copyright © 2018 Hairui's Organisation. All rights reserved.
//

import UIKit

internal struct Stack{
    
    private var elements : [UIViewController] = []
    
    mutating func push(_ newElement : UIViewController){
        elements.append(newElement)
    }

    @discardableResult
    mutating func pop()->UIViewController?{
        if elements.count > 0 {
           return elements.removeLast()
        }
        return nil
    }
    
    var topMostInterface : UIViewController{
        return elements.last!
    }
    
    func secondTopMostInterface()->UIViewController?{
        if elements.count > 1{
            return elements[elements.count - 2]
        }
        return nil 
    }
}

extension Stack : CustomStringConvertible{
    var description: String{
        
        var text = ""
        for (index, element) in elements.enumerated(){
            text += "\(index): \(String(describing: element)) \n"
        }
        return text
    }
}
