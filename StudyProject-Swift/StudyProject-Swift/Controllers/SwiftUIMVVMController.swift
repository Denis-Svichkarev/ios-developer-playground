//
//  SwiftUIMVVMController.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import UIKit
import SwiftUI

class SwiftUIMVVMController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = UserView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
