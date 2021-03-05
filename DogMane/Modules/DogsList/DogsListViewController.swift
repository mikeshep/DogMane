//
//  DogsListViewController.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


struct Dog {
    let breed: String
}

class DogsListViewController: UIViewController {
    
    //MARK: - Private vars
    private var viewModel: DogsListViewModel!
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
extension DogsListViewController {
    func binds() {
        bindTableView()
    }
    
    func bindTableView() {
        viewModel
            .items
            .asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.breed)"
                cell.detailTextLabel?.text = ""
            }
            .disposed(by: disposeBag)
    }
}

//MARK: - ViewControllerProtocol
extension DogsListViewController: ViewControllerProtocol {
    func configure(with viewModel: DogsListViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Configure View
private extension DogsListViewController {
    func configureTableView(with superView: UIView) {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        superView.addSubview(tableView)
        guard let tableView = tableView else { return }
        setConstraintsToTableView(tableView)
    }
}

//MARK: - Configure Constraints
private extension DogsListViewController {
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

