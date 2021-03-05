//
//  DogsListRouter.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit

final class DogsListRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushToDetail(with breed: String) {
        let dataSource = DogDetailViewModelDataSource(breed: breed)
        let viewController = DogDetailBuilder.build(with: dataSource)
        push(viewController: viewController)
    }
}
