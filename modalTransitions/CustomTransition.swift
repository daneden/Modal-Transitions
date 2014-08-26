//
//  CustomTransition.swift
//  modalTransitions
//
//  Created by Daniel Eden on 8/25/14.
//  Copyright (c) 2014 Daniel Eden. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning  {

    var isPresenting: Bool!
    var duration = 0.4
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        if (isPresenting == true) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            toViewController.view.transform = CGAffineTransformMakeScale(0.2, 0.2)
            
            UIView.animateWithDuration(duration,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 10,
                options: nil,
                animations: {
                    fromViewController.view.alpha = 0.3
                    toViewController.view.alpha = 1
                    toViewController.view.transform = CGAffineTransformMakeScale(0.8, 0.8)
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }

        } else {
            UIView.animateWithDuration(duration, animations: {
                
                toViewController.view.alpha = 1
                var transform = CGAffineTransformMakeScale(0, -20)
                fromViewController.view.transform = CGAffineTransformConcat(fromViewController.view.transform, transform)
                fromViewController.view.alpha = 0
                
                }, completion: { (finished: Bool) -> Void in
                    fromViewController.removeFromParentViewController()
                    transitionContext.completeTransition(true)
            })
        }
        

    }
}
