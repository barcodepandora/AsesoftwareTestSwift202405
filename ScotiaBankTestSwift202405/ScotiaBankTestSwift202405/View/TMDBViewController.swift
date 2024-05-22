//
//  TMDBViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

class TMDBViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["Arquitecto", "Locutor"])
    let filtertextField = UITextField(frame: CGRect(x: 28, y: 128, width: 267, height: 48))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Hey")
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(reactToChange), for: .valueChanged)
        segmentedControl.frame = CGRect(x: 28, y: 68, width: 198, height: 98)
        view.addSubview(segmentedControl)
        
        filtertextField.placeholder = "Tyoe"
        filtertextField.borderStyle = .roundedRect
        filtertextField.clearButtonMode = .whileEditing
        filtertextField.addTarget(self, action: #selector(handleFilter), for: .editingChanged)
        view.addSubview(filtertextField)
    }

    @objc func reactToChange() {
        print("Changed")
    }
    
    @objc func handleFilter() {
        Task {
            do {
                try await TMDBUseCase().deliverMovies()
            } catch {

            }
        }
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
