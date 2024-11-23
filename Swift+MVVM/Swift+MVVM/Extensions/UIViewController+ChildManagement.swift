//
//  UIViewController+ChildManagement.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit

extension UIViewController {
    func add(childViewController child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.didMove(toParent: self)
    }
    
    func remove(childViewController child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    func replace(oldChildViewController oldChild: UIViewController, with newChild: UIViewController) {
        add(childViewController: newChild)
        remove(childViewController: oldChild)
    }
}
