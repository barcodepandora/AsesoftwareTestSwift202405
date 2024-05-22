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
        print("Aqui vamos a TMDBVC")
        self.navigationController?.pushViewController(TMDBViewController(), animated: true)
//        Task {
//            do {
//                try await TMDBUseCase().deliverMovies()
//            } catch {
//                
//            }
//            
//        }
        
    }
    
}

