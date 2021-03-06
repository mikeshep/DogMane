//
//  MainTabBarViewController.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import RAMAnimatedTabBarController
import SnapKit
import ImagePicker

class MainTabBarViewController: RAMAnimatedTabBarController, ViewControllerProtocol {

    //MARK: - Private vars
    private var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    private var centralButton: UIButton!
    
    private lazy var firstViewController: UIViewController = {
        let firstViewController = RandomDogBuilder.build(with: RandomDogViewModelDataSource())
        let item01 = RAMAnimatedTabBarItem(title: "Mascota", image: UIImage(named: "dog"), tag: 0)
        let animation = RAMBounceAnimation()
        animation.iconSelectedColor = UIColor.primary
        animation.textSelectedColor = UIColor.primary
        item01.animation = animation
        firstViewController.tabBarItem = item01
        return firstViewController
    }()
    
    private lazy var secondViewController: UIViewController = {
        let dataSource = DogsListViewModelDataSource()
        let secondViewController = DogsListBuilder.build(with: dataSource)
        let item02 = RAMAnimatedTabBarItem(title: "Buscar", image: UIImage(named: "loupe"), tag: 0)
        let animation2 = RAMBounceAnimation()
        animation2.iconSelectedColor = UIColor.primary
        animation2.textSelectedColor = UIColor.primary
        item02.animation = animation2
        secondViewController.tabBarItem = item02
        return secondViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configure(with viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func configureButtonCenter() {
        centralButton = UIButton()
        centralButton.setImage(UIImage(named: "camera"), for: .normal)
        centralButton.backgroundColor = .white
        centralButton.sizeToFit()
        centralButton.translatesAutoresizingMaskIntoConstraints = false
        centralButton.addTarget(self, action: #selector(MainTabBarViewController.takePhoto), for: .touchUpInside)

        centralButton.snp.makeConstraints { (make) in
            make.size.equalTo(90)
        }
        centralButton.layer.cornerRadius = 45
        centralButton.layer.shadowColor = UIColor.black.cgColor
        centralButton.layer.shadowRadius = 5
        centralButton.layer.shadowOpacity = 0.75
        centralButton.layer.shadowOffset = .zero
        centralButton.isUserInteractionEnabled = true
        
        tabBar.addSubview(centralButton)
        tabBar.centerXAnchor.constraint(equalTo: centralButton.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: centralButton.centerYAnchor).isActive = true
    }
    
    func configureTabBar() {
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
        configureButtonCenter()
    }
    
    @objc func takePhoto() {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}


extension MainTabBarViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        debugPrint("wrapperDidPress")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}
