//
//  ViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func begin(_ sender: Any) {
        self.navigationController?.pushViewController(TMDBViewController(), animated: true)
    }
}

