//
//  AppDelegate.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 11/08/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let toDoView = UINavigationController(rootViewController: JobListViewController())
        let homeView = UINavigationController(rootViewController: HomeViewController())
        let cameraView = UINavigationController(rootViewController: CameraViewController())
        
        let mainTabBarController = MainTabBarController()
        mainTabBarController.setViewControllers([
            toDoView,
            homeView,
            cameraView
        ], animated: false)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
