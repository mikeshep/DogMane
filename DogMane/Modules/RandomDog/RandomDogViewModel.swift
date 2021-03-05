//
//  RandomDogViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import Foundation
import RxSwift


struct RandomDogViewModelDataSource: ViewModelDataSourceProtocol { }

final class RandomDogViewModel: ViewModelProtocol {
    private let dataSource: RandomDogViewModelDataSource
    private let router: RandomDogRouter
    
    let showBreeds = PublishSubject<Void>()

    let disposeBag = DisposeBag()
    
    init(dataSource: RandomDogViewModelDataSource, router: RandomDogRouter) {
        self.dataSource = dataSource
        self.router = router
        binds()
    }
    
    func binds()  {
        showBreeds.subscribe { _ in
            self.router.showBreeds()
        }.disposed(by: disposeBag)

    }
}
