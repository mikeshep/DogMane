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
import FSPagerView
import SnapKit
import Kingfisher

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
    private var titleLabel: UILabel!
    private var subTitleLabel: UILabel!
    private var tableView: UITableView!
    private var emptyTableViewView: UIView!
    private var emptyTitleLabel: UILabel!
    private let pagerView = FSPagerView(frame: .zero)
    
    //MARK: - Public vars
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureTitleLabel(with: view)
        configurePagerView(with: view)
        configureSubTitleLabel(with: view)
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
        bindPagerView()
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
                cell.textLabel?.contentMode = .center
                cell.textLabel?.textAlignment = .center
                cell.detailTextLabel?.text = ""
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Dog.self)
            .bind(to: viewModel.dogDetail)
            .disposed(by: disposeBag)
    }
    
    func bindPagerView() {
        viewModel
            .urls
            .asDriver(onErrorJustReturn: []).do {[weak self] _ in
                self?.pagerView.reloadData()
            }.drive()
            .disposed(by: disposeBag)

    }
    
    func bindTitle() {
        viewModel.title
            .asDriver()
            .map{ $0.capitalized }
            .drive(titleLabel.rx.text)
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
    func configureTitleLabel(with superView: UIView) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.nunitoBoldFont(withSize: 30)
        titleLabel.textAlignment = .center
        superView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(superView).offset(50)
            make.left.equalTo(superView).offset(20)
            make.right.equalTo(superView).offset(-20)
        }
    }
    
    func configurePagerView(with superView: UIView) {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.itemSize = CGSize(width: 280, height: 250)
        pagerView.interitemSpacing = 1
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        superView.addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.equalTo(superView)
            make.right.equalTo(superView)
            make.height.equalTo(300)
        }
    }
    
    func configureSubTitleLabel(with superView: UIView) {
        subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.nunitoRegularFont(withSize: 25)
        subTitleLabel.textAlignment = .center
        subTitleLabel.text = "Sub razas"
        superView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pagerView.snp.bottom)
            make.left.equalTo(superView).offset(20)
            make.right.equalTo(superView).offset(-20)
        }
    }
    
    func configureTableView(with superView: UIView) {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        superView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.bottom.equalTo(superView)
            make.left.equalTo(superView)
            make.right.equalTo(superView)
        }
    }
    
    func configureEmptyTableViewView(with superView: UIView) {
        emptyTableViewView = UIView()
        superView.addSubview(emptyTableViewView)
        guard let view = emptyTableViewView else { return}
        setConstraintsToEmptyTableViewView(view)
        configureEmptyTitleLabel(with: emptyTableViewView)
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
            emptyTitleLabel.topAnchor.constraint(equalTo: superView.topAnchor, constant: 100),
            emptyTitleLabel.centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            emptyTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: 80),
            emptyTitleLabel.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -80)
        ])
    }
}

//MARK: - Configure Constraints
private extension DogDetailViewController {

    func setConstraintsToEmptyTableViewView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}


extension DogDetailViewController: FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.urlsValue.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = viewModel.urlsValue[index]
        cell.imageView?.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    
}

extension DogDetailViewController: FSPagerViewDelegate {
    
}
