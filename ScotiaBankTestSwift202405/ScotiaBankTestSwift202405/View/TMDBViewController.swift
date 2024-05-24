//
//  TMDBViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

enum MovieOrder {
    case popularity
    case topRated
}

class TMDBViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let segmentedControl = UISegmentedControl(items: ["Popularidad", "Top Rated"])
    let filtertextField = UITextField(frame: CGRect(x: 28, y: 128, width: 267, height: 48))
    let identifier = "TMDBViewCell"
    	var viewModel: TMDBViewModelProtocol?
    var movieOrder = MovieOrder.popularity
    
    fileprivate func prepareSegmentedControl() {
        // Do any additional setup after loading the view.
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(reloadTable), for: .valueChanged)
        segmentedControl.frame = CGRect(x: 28, y: 68, width: 198, height: 98)
        view.addSubview(segmentedControl)
    }
    
    fileprivate func prepareFilter() {
        filtertextField.placeholder = "Tyoe"
        filtertextField.borderStyle = .roundedRect
        filtertextField.clearButtonMode = .whileEditing
        filtertextField.addTarget(self, action: #selector(reloadTable), for: .editingChanged)
        filtertextField.delegate = self
        view.addSubview(filtertextField)
    }
    
    fileprivate func prepareTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: self.identifier, bundle: nil), forCellReuseIdentifier: self.identifier)
        do {
            viewModel = TMDBViewModel()
            viewModel?.fetchData()
            tableView.reloadData()
        }
    }
    
    fileprivate func prepareMicrointeractions() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRecognizer.direction = .right
        view.addGestureRecognizer(swipeRecognizer)
    }
    
    fileprivate func prepareAutolayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        filtertextField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 49),
            filtertextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            filtertextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtertextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filtertextField.heightAnchor.constraint(equalToConstant: 49),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 108),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 540),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSegmentedControl()
        prepareFilter()
        prepareTable()
        prepareMicrointeractions()
        prepareAutolayout()
    }

    @objc func reloadTable() {
        movieOrder = segmentedControl.selectedSegmentIndex == 1 ? .topRated : .popularity
        tableView.reloadData()
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        Singleton.shared.main = self
        self.present(FilterFlavorAViewController(), animated: true)
    }
}

extension TMDBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let picture = "https://image.tmdb.org/t/p/original" + (viewModel?.getData(filterMovies: Singleton.shared, order: movieOrder, filter: filtertextField.text!)[indexPath.row].poster_path)!
        self.present(PictureViewController(urlPicture: picture),  animated: true)
    }
}

extension TMDBViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getData(filterMovies: Singleton.shared, order: movieOrder, filter: filtertextField.text!).count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! TMDBViewCell
        cell.labelOriginalTitle.text = viewModel?.getData(filterMovies: Singleton.shared, order: movieOrder, filter: filtertextField.text!)[indexPath.row].title
        return cell
    }
}

extension TMDBViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
