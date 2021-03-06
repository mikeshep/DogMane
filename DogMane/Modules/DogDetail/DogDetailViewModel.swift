//
//  DogDetailViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import Foundation
import Network
import RxSwift
import Kingfisher

struct DogDetailViewModelDataSource: ViewModelDataSourceProtocol {
    let breed: String
}

final class DogDetailViewModel: ViewModelProtocol {
    private let dataSource: DogDetailViewModelDataSource
    private let router: DogDetailRouter
    private let api = DogAPI()
    
    let items: PublishSubject<[Dog]> = PublishSubject()
    let urls: PublishSubject<[URL]> = PublishSubject()
    var urlsValue: [URL] = []
    let title: Variable<String> = Variable("")
    let disposeBag = DisposeBag()
    let dogDetail: PublishSubject<Dog> = PublishSubject()
    
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
        
        api.getBreedImages(dataSource.breed)
            .do(onSuccess: { [weak self] in
                guard let self = self else { return }
                self.urlsValue = $0.message
                self.urls.onNext($0.message)
            })
            .subscribe().disposed(by: disposeBag)
        
        title.value = dataSource.breed
        
        dogDetail
            .do(onNext: { [weak self] dog in
                guard let self = self else { return }
                self.getSubBreedRandomImage(from: dog)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func getSubBreedRandomImage(from dog: Dog) {
        guard let subBreed = dog.subBreed  else { return }
        api.getSubBreedRandomImage(dog.breed, subBreed: subBreed)
            .do(onSuccess: { [weak self] in
                guard let self = self else { return }
                self.showImage(from: $0.message)
            }).subscribe().disposed(by: disposeBag)
    }
    
    func showImage(from url: URL) {
        router.showImage(from: url)
    }
}


