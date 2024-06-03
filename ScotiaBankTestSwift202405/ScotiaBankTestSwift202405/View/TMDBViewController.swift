//
//  TMDBViewController.swift
//  AsesoftwareTestSwift202405
//
//  Created by Juan Manuel Moreno on 21/05/24.
//

import UIKit

class MoviesPublished {
    static let shared = MoviesPublished()
    var movies: [Movie]?
}

class ViewConstant {
    static let shared = ViewConstant()
    
    let rowH = CGFloat(89)
    
    let identifier = "TMDBViewCell"

    let FilteredY = 128
    let FilteredW = 267
    let FilteredH = 48
    let FilteredAutolayoutT = 64

    let SegmentedX = 28
    let SegmentedY = 68
    let SegmentedW = 198
    let SegmentedH = 98
    let SegmentedAutolayoutH = 49
    
    let TableAutolayoutT = 108
    let TableAutolayoutH = 540
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
        do {
            viewModel = TMDBViewModel()
            try viewModel?.fetchData()
            refreshTable()
        } catch  {
            let alert = UIAlertController(title: "Error", message: "No data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in print("OK") })
            present(alert, animated: true)
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
            segmentedControl.heightAnchor.constraint(equalToConstant: CGFloat(ViewConstant.shared.SegmentedAutolayoutH)),

            filtertextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(ViewConstant.shared.FilteredAutolayoutT)),
            filtertextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtertextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filtertextField.heightAnchor.constraint(equalToConstant: CGFloat(ViewConstant.shared.SegmentedAutolayoutH)),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(ViewConstant.shared.TableAutolayoutT)),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(ViewConstant.shared.TableAutolayoutH)),
        ])
    }
    
    func orderData(order: MovieOrder, filter: String) -> [Movie] {
        return (viewModel?.orderData(moviesForOrder: MoviesPublished.shared.movies!, order: order, filter: filter))!
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
        self.present(PictureViewController(urlPicture: MoviesPublished.shared.movies![indexPath.row].poster_path!), animated: true)
    }
}

extension TMDBViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviesPublished.shared.movies!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConstant.shared.rowH
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewConstant.shared.identifier, for: indexPath) as! TMDBViewCell
        cell.labelOriginalTitle.text = MoviesPublished.shared.movies![indexPath.row].title
        let imageUrl = MoviesPublished.shared.movies![indexPath.row].poster_path! //?? ""
//        AsyncImageLoader.shared.loadImage(from: imageUrl) { [weak self] image in
//            cell.photo?.image = image
//        }
        cell.configure(with: imageUrl)
        return cell
    }
}

extension TMDBViewController: UITextFieldDelegate {}

extension TMDBViewController: TMDBDelegateProtocol {
    @objc func refreshTable() {
        movieOrder = segmentedControl.selectedSegmentIndex == 1 ? .topRated : .popularity
        MoviesPublished.shared.movies = viewModel?.getData(filterMovies: Handler.shared, order: movieOrder, filter: filtertextField.text!) ?? []
        tableView.reloadData()
    }
}
