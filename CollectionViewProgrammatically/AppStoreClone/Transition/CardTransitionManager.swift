//
//  CardTransitionManager.swift
//  CardTransitionManager
//
//  Created by Cong Le on 8/20/21.
//

import UIKit

enum CardTransitionType {
  case presentation
  case dismissal
}

class CardTransitionManager: NSObject {
  let transitionDuration: Double = 0.8
  var transition: CardTransitionType = .presentation
  let shrinkDuration: Double = 0.2
}

// MARK: - UIViewControllerAnimatedTransitioning
extension CardTransitionManager: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return transitionDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
  }
  
  
}

//MARK: - UIViewControllerTransitioningDelegate
extension CardTransitionManager: UIViewControllerTransitioningDelegate {
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition = .presentation
    return self
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition = .dismissal
    return self
  }
}
