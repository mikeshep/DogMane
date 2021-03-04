//
//  ViewModelProtocol.swift
//  Uala
//
//  Created by Miguel Angel Olmedo Perez on 02/03/21.
//

import Foundation

protocol ViewModelProtocol: class {
    associatedtype DataSource: ViewModelDataSourceProtocol
    associatedtype Router: RouterProtocol

    init(dataSource: DataSource, router: Router)
}
