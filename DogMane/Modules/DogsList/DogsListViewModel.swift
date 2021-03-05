//
//  DogsListViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import Foundation
import Network
import RxSwift
import RealmSwift

struct DogsListViewModelDataSource: ViewModelDataSourceProtocol {
    var isPopUp: Bool = false
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
                guard let self = self else { return }
                if self.dataSource.isPopUp {
                    self.saveDog(dog)
                    self.router.closePopUp()
                } else {
                    self.router.pushToDetail(with: dog.breed)
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func saveDog(_ dog: Dog) {
        let realm = try! Realm()
        let dogs = realm.objects(DogObject.self).filter { $0.breed == dog.breed }
        guard dogs.count == 0 else {
            return
        }
        let myDog = DogObject()
        myDog.breed = dog.breed
        if let subBreed = dog.subBreed {
            myDog.subBreed = subBreed
        }
        try! realm.write {
            realm.deleteAll()
        }
        try! realm.write {
            realm.add(myDog)
        }
    }
}

class DogObject: Object {
    @objc dynamic var breed = ""
    @objc dynamic var subBreed = ""
}

