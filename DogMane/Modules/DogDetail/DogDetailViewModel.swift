//
//  DogDetailViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import Foundation
import Network
import RxSwift

struct DogDetailViewModelDataSource: ViewModelDataSourceProtocol {
    let breed: String
}

final class DogDetailViewModel: ViewModelProtocol {
    private let dataSource: DogDetailViewModelDataSource
    private let router: DogDetailRouter
    private let api = DogAPI()
    
    let items: PublishSubject<[Dog]> = PublishSubject()
    let disposeBag = DisposeBag()
    
    init(dataSource: DogDetailViewModelDataSource, router: DogDetailRouter) {
        self.dataSource = dataSource
        self.router = router
        binds()
    }
    
    func binds() {
        api.getAllSubBreeds(for: dataSource.breed)
            .do(onSuccess: { [weak self] in
                guard let self = self else { return }
                let items = $0.message.map( { Dog.init(breed: self.dataSource.breed, subBreed: $0) } )
                self.items.onNext(items)
            })
            .subscribe().disposed(by: disposeBag)
    }
}


