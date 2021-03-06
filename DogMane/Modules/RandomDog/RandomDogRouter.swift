//
//  RandomDogRouter.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import UIKit
import SBCardPopup
import SnapKit

final class RandomDogRouter: RouterProtocol {
    internal weak var viewController: UIViewController?

    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showBreeds() {
        let dataSource = DogsListViewModelDataSource(isPopUp: true)
        let viewController = DogsListBuilder.build(with: dataSource)
        let cardPopup = SBCardPopupViewController(contentViewController: viewController)
        viewController.view.snp.makeConstraints { (make) in
            let width = (self.viewController?.view.frame.width ?? 0.0)*0.8
            let height = (self.viewController?.view.frame.height ?? 0.0)*0.6
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        guard let tabBarController = self.viewController?.tabBarController else { return }
        cardPopup.show(onViewController: tabBarController)
    }
}
