//
//  RouterProtocol.swift
//  Uala
//
//  Created by Miguel Angel Olmedo Perez on 02/03/21.
//

import Foundation
import UIKit

protocol RouterProtocol {
    var viewController: UIViewController? { get }
    init(viewController: UIViewController)
    func routeBack()
}

extension RouterProtocol {
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func push(viewController: UIViewController, isAlphaTransition: Bool = false) {
        guard isAlphaTransition else {
            self.viewController?.navigationController?.delegate = nil
            self.viewController?.navigationController?.pushViewController(viewController, animated: true)
            return
        }
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
