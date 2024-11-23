//
//  RootController.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import UIKit

class RootController: UIViewController {
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSwiftBasicsButtonPressed(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SwiftBasicsController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPatternsButtonPressed(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PatternsController")
        navigationController?.pushViewController(vc, animated: true)
    }
}
