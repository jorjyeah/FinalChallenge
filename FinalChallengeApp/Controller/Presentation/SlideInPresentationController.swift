//
//  SlideInPresentationController.swift
//  FinalChallengeApp
//
//  Created by Ni Wayan Bianka Aristania on 17/12/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
       // MARK: - Properties
       private var dimmingView: UIView!
       private var direction: PresentationDirection
       
       override var frameOfPresentedViewInContainerView: CGRect {
         
         var frame: CGRect = .zero
         frame.size = size(forChildContentContainer: presentedViewController,
                           withParentContainerSize: containerView!.bounds.size)

         
         switch direction {
         case .bottom:
           frame.origin.y = containerView!.frame.height*(2.0/3.0)
         default:
           frame.origin = .zero
         }
         return frame
       }

       
       init(presentedViewController: UIViewController,
            presenting presentingViewController: UIViewController?,
            direction: PresentationDirection) {
         self.direction = direction

         
         super.init(presentedViewController: presentedViewController,
                    presenting: presentingViewController)
           setupDimmingView()
       }
       
       override func presentationTransitionWillBegin() {
         guard let dimmingView = dimmingView else {
           return
         }
         // 1
         containerView?.insertSubview(dimmingView, at: 0)

         // 2
         NSLayoutConstraint.activate(
           NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
             options: [], metrics: nil, views: ["dimmingView": dimmingView]))
         NSLayoutConstraint.activate(
           NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
             options: [], metrics: nil, views: ["dimmingView": dimmingView]))

         //3
         guard let coordinator = presentedViewController.transitionCoordinator else {
           dimmingView.alpha = 1.0
           return
         }

         coordinator.animate(alongsideTransition: { _ in
           self.dimmingView.alpha = 1.0
         })
       }
       
       override func dismissalTransitionWillBegin() {
         guard let coordinator = presentedViewController.transitionCoordinator else {
           dimmingView.alpha = 0.0
           return
         }

         coordinator.animate(alongsideTransition: { _ in
           self.dimmingView.alpha = 0.0
         })
       }
       
       override func containerViewWillLayoutSubviews() {
         presentedView?.frame = frameOfPresentedViewInContainerView
       }
       
       override func size(forChildContentContainer container: UIContentContainer,
                          withParentContainerSize parentSize: CGSize) -> CGSize {
         switch direction {
         case .bottom:
           return CGSize(width: parentSize.width, height: parentSize.height*(1.0/3.0))
         }
       }
}

// MARK: - Private
private extension SlideInPresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
    dimmingView.alpha = 0.0
    
    let recognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(handleTap(recognizer:)))
    dimmingView.addGestureRecognizer(recognizer)
  }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
      presentingViewController.dismiss(animated: true)
    }
}
