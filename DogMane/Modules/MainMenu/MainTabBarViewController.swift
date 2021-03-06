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

class MainTabBarViewController: RAMAnimatedTabBarController, ViewControllerProtocol {
    
    //MARK: - Private vars
    private var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    lazy var firstViewController: UIViewController = {
        let firstViewController = RandomDogBuilder.build(with: RandomDogViewModelDataSource())
        let item01 = RAMAnimatedTabBarItem(title: "Mascota", image: UIImage(named: "dog"), tag: 0)
        let animation = RAMBounceAnimation()
        animation.iconSelectedColor = UIColor.primary
        animation.textSelectedColor = UIColor.primary
        item01.animation = animation
        firstViewController.tabBarItem = item01
        return firstViewController
    }()
    
    lazy var secondViewController: UIViewController = {
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
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.backgroundColor = .white
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.snp.makeConstraints { (make) in
            make.size.equalTo(60)
        }
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.75
        button.layer.shadowOffset = .zero
        
        tabBar.addSubview(button)
        tabBar.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        tabBar.topAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }
    
    func configureTabBar() {
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
        configureButtonCenter()
    }
}
