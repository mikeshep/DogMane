//
//  DogDetailViewController.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class DogDetailViewController: UIViewController {
    
    //MARK: - Private vars
    private var viewModel: DogDetailViewModel!
    private let disposeBag = DisposeBag()
    
    //MARK: - Public vars
    var tableView: UITableView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureTableView(with: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hola mundo :'v"
        binds()
    }
}
//MARK: - Bind View Model
extension DogDetailViewController {
    func binds() {
        bindTableView()
    }
    
    func bindTableView() {
        viewModel
            .items
            .asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.subBreed
                cell.detailTextLabel?.text = ""
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - ViewControllerProtocol
extension DogDetailViewController: ViewControllerProtocol {
    func configure(with viewModel: DogDetailViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Configure View
private extension DogDetailViewController {
    func configureTableView(with superView: UIView) {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        superView.addSubview(tableView)
        guard let tableView = tableView else { return }
        setConstraintsToTableView(tableView)
    }
}

//MARK: - Configure Constraints
private extension DogDetailViewController {
    func setConstraintsToTableView(_ tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

