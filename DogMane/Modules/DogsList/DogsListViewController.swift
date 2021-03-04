//
//  DogsListViewController.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit
import RxCocoa

class DogsListViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        //Configure tableView
        configureTableView(with: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hola mundo :'v"
    }
}

private extension DogsListViewController {
    func configureTableView(with superView: UIView) {
        tableView = UITableView()
        superView.addSubview(tableView)
        guard let tableView = tableView else { return }
        setConstraintsToTableView(tableView)
    }
    
    func setConstraintsToTableView(_ tableView: UITableView) {
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[tableView]-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["tableView": tableView])
        NSLayoutConstraint.activate(horizontalConstraints)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[tableView]-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["tableView": tableView])
        NSLayoutConstraint.activate(verticalConstraints)
    }
}

