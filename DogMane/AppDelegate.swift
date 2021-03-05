//
//  AppDelegate.swift
//  DogMane
//
//  Created by Miguel Angel Olmedo Perez on 04/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        let dataSource = MainViewModelDataSource()
        let viewController = MainBuilder.build(with: dataSource)
        //let navigationController = UINavigationController.init(rootViewController: viewController)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        return true
    }
}

