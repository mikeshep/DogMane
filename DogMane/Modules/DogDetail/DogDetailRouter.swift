//
//  DogDetailRouter.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit
import SBCardPopup
import Kingfisher

final class DogDetailRouter: RouterProtocol {
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showImage(from url: URL) {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        KF.url(url)
          .placeholder(UIImage(named: "placeholder"))
          .loadDiskFileSynchronously()
          .cacheMemoryOnly()
          .fade(duration: 0.25)
          .callbackQueue(.dispatch(.global(qos: .background)))
          .set(to: imageView)
        
        let cardPopup = SBCardPopupViewController(contentView: imageView)
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
        guard let viewController = self.viewController else { return }
        cardPopup.show(onViewController: viewController)
    }

}

