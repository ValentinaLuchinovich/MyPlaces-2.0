//
//  NavigationController.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    private var gesture: UIScreenEdgePanGestureRecognizer?
        
    /// Return `true` if dismissal is allowed
    open var popHandler: (() -> Bool)? {
        didSet {
            if popHandler != nil {
                interactivePopGestureRecognizer?.isEnabled = false
                gesture?.isEnabled = true
            } else {
                interactivePopGestureRecognizer?.isEnabled = true
                gesture?.isEnabled = false
            }
        }
    }

    /// handle edge swipe cases
    @objc private func onEdgeSwipe(gesture: UIPanGestureRecognizer) {
        // handle dismissals via edge swipes
        if gesture.state == .began {
            if popHandler?() == false
            {
                return
            }
            self.popHandler = nil
            if viewControllers.count > 1 {
                viewControllers.last?.dismiss(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }

    open override func popViewController(animated: Bool) -> UIViewController?
    {
        guard self.popHandler?() != false else { return nil }
        self.popHandler = nil
        return super.popViewController(animated: animated)
    }
        
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(onEdgeSwipe(gesture:)))
        gesture?.delegate = self
        gesture?.edges = .left
        gesture?.isEnabled = false
        view.addGestureRecognizer(gesture!)
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
      }
}
