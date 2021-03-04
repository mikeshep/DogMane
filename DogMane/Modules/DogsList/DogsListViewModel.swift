//
//  DogsListViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import Foundation

struct DogsListViewModelDataSource: ViewModelDataSourceProtocol {
    
}

class DogsListViewModel: ViewModelProtocol {
    private let dataSource: DogsListViewModelDataSource
    private let router: SearchRouter
    
    
    init(dataSource: DogsListViewModelDataSource, router: DogsListRouter) {
        self.dataSource = dataSource
        self.router = router
        //binds()
    }
}
