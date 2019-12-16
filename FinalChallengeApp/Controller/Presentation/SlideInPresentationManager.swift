//
//  SlideInPresentationManager.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 16/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case bottom
}

class SlideInPresentationManager: NSObject {
     var direction: PresentationDirection = .bottom
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(
      forPresented presented: UIViewController,
      presenting: UIViewController?,
      source: UIViewController
    ) -> UIPresentationController? {
      let presentationController = SlideInPresentationController(
        presentedViewController: presented,
        presenting: presenting,
        direction: direction
      )
      return presentationController
    }
}
