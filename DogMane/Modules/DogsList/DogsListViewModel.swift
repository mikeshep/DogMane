//
//  DogsListViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import Foundation
import Network
import RxSwift

struct DogsListViewModelDataSource: ViewModelDataSourceProtocol {
    
}

final class DogsListViewModel: ViewModelProtocol {
    private let dataSource: DogsListViewModelDataSource
    private let router: DogsListRouter
    private let api = DogAPI()
    
    let items: PublishSubject<[Dog]> = PublishSubject()
    let dogDetail: PublishSubject<Dog> = PublishSubject()
    let disposeBag = DisposeBag()
    
    init(dataSource: DogsListViewModelDataSource, router: DogsListRouter) {
        self.dataSource = dataSource
        self.router = router
        binds()
    }
    
    func binds() {
        api.getAllBreeds()
            .do(onSuccess: { [weak self] in self?.items.onNext($0.message.keys.map(Dog.init).sorted(by: { $0.breed < $1.breed })) })
            .subscribe().disposed(by: disposeBag)
        
        dogDetail
            .do(onNext: { [weak self] dog in
                self?.router.pushToDetail(with: dog.breed)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}


