//
//  HomeViewController.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 13.07.2024.
//

import SwiftUI
import UIKit

class HomeViewController: UIViewController {
    var userViewModel: UserViewModel?
   
    init(userViewModel: UserViewModel) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userViewModel = userViewModel else { return }
        let homeTabView = HomeTabView(userViewModel: userViewModel)
        let hostingController = UIHostingController(rootView: homeTabView)
                
        addChild(hostingController)
        view.addSubview(hostingController.view)
                
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
                
        hostingController.didMove(toParent: self)
    }
}
