//
//  ViewControllerProtocol.swift
//  Uala
//
//  Created by Miguel Angel Olmedo Perez on 02/03/21.
//

import UIKit

protocol ViewControllerProtocol: UIViewController {
    associatedtype ViewModel: ViewModelProtocol
    func configure(with viewModel: ViewModel)
    static func instantiate() -> Self
}

extension ViewControllerProtocol {
    static func instantiate() -> Self {
        UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}
