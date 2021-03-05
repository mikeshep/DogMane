//
//  RandomDogViewController.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class RandomDogViewController: UIViewController {
    
    //MARK: - Private vars
    private var viewModel: RandomDogViewModel!
    private let disposeBag = DisposeBag()
    private var titleLabel = UILabel()
    private var emptyLabel = UILabel()
    private var imageView: UIImageView!
    private var selectBreedButton: UIButton!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        configureTitleLabel(with: view)
        configureEmptyLabel(with: view)
        configureSelectBreedButton(with: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        binds()
    }
}

//MARK: - Bind View Model
extension RandomDogViewController {
    func binds() {
        selectBreedButton.rx
            .controlEvent(.touchUpInside)
            .bind(to: viewModel.showBreeds)
            .disposed(by: disposeBag)
    }
}

//MARK: - ViewControllerProtocol
extension RandomDogViewController: ViewControllerProtocol {
    func configure(with viewModel: RandomDogViewModel) {
        self.viewModel = viewModel
    }
}

//MARK: - Configure View
private extension RandomDogViewController {
    func cofigureImageView(with parentView: UIView) {
        imageView = UIImageView()
        parentView.addSubview(imageView)
        guard let imageView = imageView  else { return }
        setConstraintsToImageView(imageView)
    }
    
    func configureTitleLabel(with superView: UIView) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.nunitoBoldFont(withSize: 30)
        titleLabel.text = "DogMane"
        superView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(superView).offset(90)
            make.left.equalTo(superView).offset(20)
            make.right.equalTo(superView).offset(-20)
        }
    }
    
    func configureEmptyLabel(with superView: UIView) {
        emptyLabel = UILabel()
        emptyLabel.font = UIFont.nunitoRegularFont(withSize: 25)
        emptyLabel.text = "Aún no has seleccionado una raza"
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        superView.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).offset(100)
            make.left.equalTo(superView).offset(20)
            make.right.equalTo(superView).offset(-20)
        }
    }
    
    func configureSelectBreedButton(with superView: UIView) {
        selectBreedButton = UIButton(frame: .zero)
        selectBreedButton.titleLabel?.font = UIFont.nunitoRegularFont(withSize: 25)
        selectBreedButton.setTitle("Ver Razas", for: .normal)
        selectBreedButton.titleLabel?.textAlignment = .center
        selectBreedButton.setTitleColor(.primary, for: .normal)
        superView.addSubview(selectBreedButton)
        
        selectBreedButton.snp.makeConstraints { (make) in
            make.top.equalTo(emptyLabel).offset(100)
            make.left.equalTo(superView).offset(20)
            make.right.equalTo(superView).offset(-20)
        }
    }
}

//MARK: - Configure Constraints
private extension RandomDogViewController {
    func setConstraintsToImageView(_ imageView: UIImageView) {
 
    }
}

