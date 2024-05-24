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

    func popFilter() {
        Handler.shared.research()
        self.dismiss(animated: true)
    }
    
    @IBAction func chooseNoAdult(_ sender: Any) {
        Handler.shared.adult = Adult.allMinusAdult
        popFilter()
    }
    
    @IBAction func chooseAll(_ sender: Any) {
        Handler.shared.adult = Adult.all
        popFilter()
    }
    
    @IBAction func chooseAdult(_ sender: Any) {
        Handler.shared.adult = Adult.adult
        popFilter() 
    }
    
    @IBAction func chooseAllLanguages(_ sender: Any) {
        Handler.shared.language = Language.all
        popFilter()
    }
    
    @IBAction func chooseEnglish(_ sender: Any) {
        Handler.shared.language = Language.english
        popFilter()
    }
    
    @IBAction func chooseFrench(_ sender: Any) {
        Handler.shared.language = Language.francaise
        popFilter()
    }
    
    @IBAction func chooseAllAverages(_ sender: Any) {
        Handler.shared.average = Average.all
        popFilter()
    }
    
    @IBAction func chooseLessThan5K(_ sender: Any) {
        Handler.shared.average = Average.lessThan5K
        popFilter()
    }
    
    @IBAction func chooseMoreThan5K(_ sender: Any) {
        Handler.shared.average = Average.moreThan5K
        popFilter()
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
