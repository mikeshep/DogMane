//
//  MainRouter.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import UIKit

final class MainRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
