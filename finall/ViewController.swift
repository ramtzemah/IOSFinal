//
//  ViewController.swift
//  finall
//
//  Created by רם צמח on 14/07/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
                            // The view controller is embedded in a navigation controller
                            // You can safely use pushViewController(_:animated:) here
                            let storyboard = UIStoryboard(name: "View", bundle: nil)
                            let ctrl = storyboard.instantiateViewController(identifier: "LoginViewController")
                            navigationController.pushViewController(ctrl, animated: true)
                        } else {
                            // The view controller is not embedded in a navigation controller
                            // pushViewController(_:animated:) will not work here
                            print("The view controller is not embedded in a navigation controller.")
                        }
        print("111")
        // Do any additional setup after loading the view.
    }


}

