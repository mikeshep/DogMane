//
//  DogDetailRouter.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit

final class DogDetailRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
