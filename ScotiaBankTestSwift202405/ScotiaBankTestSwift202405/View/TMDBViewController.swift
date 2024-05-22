//
//  TMDBViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

class TMDBViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let segmentedControl = UISegmentedControl(items: ["Arquitecto", "Locutor"])
    let filtertextField = UITextField(frame: CGRect(x: 28, y: 128, width: 267, height: 48))
    let identifier = "TMDBViewCell"
    var data: TMDB?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Hey")
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(reactToChange), for: .valueChanged)
        segmentedControl.frame = CGRect(x: 28, y: 68, width: 198, height: 98)
        view.addSubview(segmentedControl)
        
        data = TMDB()
        
        filtertextField.placeholder = "Tyoe"
        filtertextField.borderStyle = .roundedRect
        filtertextField.clearButtonMode = .whileEditing
        filtertextField.addTarget(self, action: #selector(handleFilter), for: .editingChanged)
        view.addSubview(filtertextField)
        
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: self.identifier, bundle: nil), forCellReuseIdentifier: self.identifier)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRecognizer.direction = .right
        view.addGestureRecognizer(swipeRecognizer)
    }

    @objc func reactToChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            data!.results! = data!.results!.sorted { $0.popularity! > $1.popularity! }
        case 1:
            data!.results! = data!.results!.sorted { $0.vote_count! > $1.vote_count! }
        default:
            break
        }
        tableView.reloadData()
    }
    
    @objc func handleFilter() {
        Task {
            do {
                data = try await TMDBUseCase().deliverMovies()
                tableView.reloadData()
            } catch {

            }
        }
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        Singleton.shared.main = self
        self.present(FilterFlavorAViewController(), animated: true)
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

extension TMDBViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data!.results!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! TMDBViewCell
        cell.labelOriginalTitle.text = data!.results![indexPath.row].title
        return cell
    }
    
    
}
