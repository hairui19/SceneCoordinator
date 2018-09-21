//
//  CustomTransition.swift
//  SceneCoordinator_Example
//
//  Created by Hairui on 21/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CustomTransition : NSObject{
    
    
}

extension CustomTransition : UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}

extension CustomTransition : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        print("called in here?s")
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentedView = transitionContext.view(forKey: .to)!
        
        let containerView = transitionContext.containerView
        presentedView.alpha = 0
        containerView.addSubview(presentedView)
        
        UIView.animate(withDuration: 0.4, animations: {
            presentedView.alpha = 1
        }) { (success) in
            transitionContext.completeTransition(success)
        }
    }
    
    
}
