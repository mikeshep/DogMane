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

struct AnimatedSectionModel {
    let title: String
    var data: [URL]
}
extension URL: IdentifiableType {
    public typealias Identity = String
    public var identity: String { return path }
    
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    
    typealias Item = URL
    typealias Identity = String
    
    var identity: Identity { return title }
    var items: [Item] { return data }
    
    init(original: AnimatedSectionModel, items: [URL]) {
        self = original
        data = items
    }
}

class DogDetailViewController: UIViewController {
    
    //MARK: - Private vars
    private var viewModel: DogDetailViewModel!
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    private var emptyTableViewView: UIView!
    private var emptySearchImageView: UIImageView!
    private var emptyTitleLabel: UILabel!
    
    //MARK: - Public vars
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureCollectionView(with: view)
        configureEmptyTableViewView(with: view)
        configureTableView(with: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binds()
    }
}
//MARK: - Bind View Model
extension DogDetailViewController {
    func binds() {
        bindTableView()
        bindCollectionView()
        bindTitle()
        bindEmptyTableViewView()
    }
    
    func bindTableView() {
        viewModel
            .items
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.subBreed?.capitalized
                cell.textLabel?.font = UIFont.nunitoBoldFont(withSize: 20)
                cell.detailTextLabel?.text = ""
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    func bindCollectionView() {
        viewModel
            .urls
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: "Cell", cellType: DogDetailCollectionViewCell.self)) { (row, element, cell) in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }
    
    func bindTitle() {
        viewModel.title
            .asDriver()
            .drive { [unowned self] in self.title = $0.capitalized }
            .disposed(by: disposeBag)
    }
    
    func bindEmptyTableViewView() {
        viewModel.items
            .asDriver(onErrorJustReturn: [])
            .map { !$0.isEmpty }
            .drive(emptyTableViewView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.items
            .asDriver(onErrorJustReturn: [])
            .map { $0.isEmpty }
            .drive(tableView.rx.isHidden)
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
    
    func configureCollectionView(with superView: UIView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 240, height: 240)
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(DogDetailCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        superView.addSubview(collectionView)
        guard let collectionView = collectionView else { return}
        setConstraintsToCollectionView(collectionView)
    }
    
    func configureEmptyTableViewView(with superView: UIView) {
        emptyTableViewView = UIView()
        superView.addSubview(emptyTableViewView)
        guard let view = emptyTableViewView else { return}
        setConstraintsToEmptyTableViewView(view)
        configureEmptySearchImageVieww(with: emptyTableViewView)
        configureEmptyTitleLabel(with: emptyTableViewView)
    }
    
    func configureEmptySearchImageVieww(with superView: UIView) {
        emptySearchImageView = UIImageView()
        emptySearchImageView.image = UIImage(named: "emptySearch")
        emptySearchImageView.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(emptySearchImageView)
        guard let emptySearchImageView = emptySearchImageView else { return }
        NSLayoutConstraint.activate([
            emptySearchImageView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 100),
            emptySearchImageView.centerXAnchor.constraint(equalTo: superView.centerXAnchor)
        ])
    }
    
    func configureEmptyTitleLabel(with superView: UIView) {
        emptyTitleLabel = UILabel()
        emptyTitleLabel.text = "Es la única raza para este canino"
        emptyTitleLabel.font = UIFont.nunitoBoldFont(withSize: 30)
        emptyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyTitleLabel.numberOfLines = 0
        emptyTitleLabel.textAlignment = .center
        superView.addSubview(emptyTitleLabel)
        guard let emptyTitleLabel = emptyTitleLabel else { return }
        NSLayoutConstraint.activate([
            emptyTitleLabel.topAnchor.constraint(equalTo: emptySearchImageView.bottomAnchor, constant: 50),
            emptyTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: 80),
            emptyTitleLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -80)
        ])
    }
}

//MARK: - Configure Constraints
private extension DogDetailViewController {
    func setConstraintsToCollectionView(_ collectionView: UICollectionView) {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            collectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 250)
        ])
    }
    
    func setConstraintsToEmptyTableViewView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setConstraintsToTableView(_ tableView: UITableView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}

