//
//  RandomDogViewModel.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 05/03/21.
//

import Foundation
import RxSwift
import RealmSwift
import Network



struct RandomDogViewModelDataSource: ViewModelDataSourceProtocol { }

final class RandomDogViewModel: ViewModelProtocol {
    private let dataSource: RandomDogViewModelDataSource
    private let router: RandomDogRouter
    private var token: NotificationToken!
    
    let petDog = PublishSubject<Dog>()
    let urlPetDog = PublishSubject<URL>()
    let showBreeds = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    let api = DogAPI()
    
    init(dataSource: RandomDogViewModelDataSource, router: RandomDogRouter) {
        self.dataSource = dataSource
        self.router = router
        subscribeToRealm()
        binds()
    }
    
    func binds()  {
        showBreeds.subscribe { _ in
            self.router.showBreeds()
        }.disposed(by: disposeBag)
        
        petDog.subscribe { [weak self] response in
            guard let self = self, let breed = response.element?.breed else { return }
            self.getRandomImage(for: breed)
        }.disposed(by: disposeBag)
    }
    
    func getRandomImage(for breed: String) {
        api.getBreedRandomImage(breed).subscribe { [weak self] (response) in
            guard let self = self else { return }
            self.urlPetDog.onNext(response.message)
        } onError: { (error) in
            debugPrint(error)
        }.disposed(by: self.disposeBag)
    }
    
    func subscribeToRealm() {
        let realm = try! Realm()
        let dogs = realm.objects(DogObject.self)
        token = dogs.observe { [weak self] (changes) in
            switch changes {
            case .initial:
                self?.updatePetDog()
            case .update(_, _, let insertions, _):
                guard insertions.first != nil else { return }
                self?.updatePetDog()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    func updatePetDog() {
        let realm = try! Realm()
        let dogs = realm.objects(DogObject.self)
        guard let first = dogs.first else {
            return
        }
        let dog = Dog(breed: first.breed, subBreed: first.subBreed)
        petDog.onNext(dog)
    }
    
    deinit {
        token.invalidate()
    }
}
