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

class MainTabBarViewController: RAMAnimatedTabBarController, ViewControllerProtocol {
    
    //MARK: - Private vars
    private var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstViewController = RandomDogBuilder.build(with: RandomDogViewModelDataSource())
        firstViewController.view.backgroundColor = .white
        let item01 = RAMAnimatedTabBarItem(title: "Mascota", image: UIImage(named: "dog"), tag: 0)
        item01.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let animation = RAMBounceAnimation()
        animation.iconSelectedColor = UIColor.primary
        animation.textSelectedColor = UIColor.primary
        item01.animation = animation
        firstViewController.tabBarItem = item01

        let dataSource = DogsListViewModelDataSource()
        let secondViewController = DogsListBuilder.build(with: dataSource)
        secondViewController.view.backgroundColor = .red
        let item02 = RAMAnimatedTabBarItem(title: "Buscar", image: UIImage(named: "loupe"), tag: 0)
        let animation2 = RAMBounceAnimation()
        animation2.iconSelectedColor = UIColor.primary
        animation2.textSelectedColor = UIColor.primary
        item02.animation = animation2

        secondViewController.tabBarItem = item02

        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isTranslucent = false
        tabBar.tintColor = .red
    }
    
    func configure(with viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
}
