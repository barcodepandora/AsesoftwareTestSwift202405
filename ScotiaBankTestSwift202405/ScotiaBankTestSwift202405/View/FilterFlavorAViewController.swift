//
//  FilterFlavorAViewController.swift
//  ScotiaBankTestSwift202405
//
//  Created by Juan Manuel Moreno on 22/05/24.
//

import UIKit

class FilterFlavorAViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func chooseNoAdult(_ sender: Any) {
        Singleton.shared.adult = Adult.allMinusAdult
        Singleton.shared.research()
        self.dismiss(animated: true)
    }
    
    @IBAction func chooseAll(_ sender: Any) {
        Singleton.shared.adult = Adult.all
    }
    
    @IBAction func chooseAdult(_ sender: Any) {
        Singleton.shared.adult = Adult.adult
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
