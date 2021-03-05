//
//  MainViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import Foundation
import RxSwift


struct MainViewModelDataSource: ViewModelDataSourceProtocol { }

final class MainViewModel: ViewModelProtocol {
    private let dataSource: MainViewModelDataSource
    private let router: MainRouter

    let disposeBag = DisposeBag()
    
    init(dataSource: MainViewModelDataSource, router: MainRouter) {
        self.dataSource = dataSource
        self.router = router
        //binds()
    }
}
