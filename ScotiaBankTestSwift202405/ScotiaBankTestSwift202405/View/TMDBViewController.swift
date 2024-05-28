//
//  TMDBViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

class ViewConstant {
    static let shared = ViewConstant()
    
    let rowH = CGFloat(89)

    let FilteredY = 128
    let FilteredW = 267
    let FilteredH = 48

    let identifier = "TMDBViewCell"

    let SegmentedX = 28
    let SegmentedY = 68
    let SegmentedW = 198
    let SegmentedH = 98
}

enum MovieOrder {
    case popularity
    case topRated
}

class TMDBViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let segmentedControl = UISegmentedControl(items: ["Popularidad", "Top Rated"])
    let filtertextField = UITextField(frame: CGRect(x: ViewConstant.shared.SegmentedX, y: ViewConstant.shared.FilteredY, width: ViewConstant.shared.FilteredW, height: ViewConstant.shared.FilteredH))
    var viewModel: TMDBViewModelProtocol?
    var movieOrder = MovieOrder.popularity
    
    fileprivate func prepareSegmentedControl() {
        // Do any additional setup after loading the view.
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        segmentedControl.frame = CGRect(x: ViewConstant.shared.SegmentedX, y: ViewConstant.shared.SegmentedY, width: ViewConstant.shared.SegmentedW, height: ViewConstant.shared.SegmentedH)
        view.addSubview(segmentedControl)
    }
    
    fileprivate func prepareFilter() {
        filtertextField.placeholder = "Escribir"
        filtertextField.borderStyle = .roundedRect
        filtertextField.clearButtonMode = .whileEditing
        filtertextField.addTarget(self, action: #selector(refreshTable), for: .editingChanged)
        filtertextField.delegate = self
        view.addSubview(filtertextField)
    }
    
    fileprivate func prepareTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ViewConstant.shared.identifier, bundle: nil), forCellReuseIdentifier: ViewConstant.shared.identifier)
//        do {
            viewModel = TMDBViewModel()
            viewModel?.fetchData()
            refreshTable()
//        }
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
    
    func orderData(order: MovieOrder, filter: String) -> [Movie] {
        return (viewModel?.orderData(order: order, filter: filter))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSegmentedControl()
        prepareFilter()
        prepareTable()
        prepareMicrointeractions()
        prepareAutolayout()
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        Handler.shared.vc = self
        self.present(FilterFlavorAViewController(), animated: true)
    }
}

extension TMDBViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let picture = Handler.shared.moviesThosePresent[indexPath.row].poster_path!
        self.present(PictureViewController(urlPicture: picture),  animated: true)
    }
}

extension TMDBViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Handler.shared.moviesThosePresent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstant.shared.rowH
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstant.shared.identifier, for: indexPath) as! TMDBViewCell
        cell.labelOriginalTitle.text = Handler.shared.moviesThosePresent[indexPath.row].title
        return cell
    }
}

extension TMDBViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

extension TMDBViewController: TMDBDelegateProtocol {
    @objc func refreshTable() {
        movieOrder = segmentedControl.selectedSegmentIndex == 1 ? .topRated : .popularity
        Handler.shared.moviesThosePresent = viewModel?.getData(filterMovies: Handler.shared, order: movieOrder, filter: filtertextField.text!) ?? []
        tableView.reloadData()
    }
}
