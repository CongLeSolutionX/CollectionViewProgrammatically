//
//  AppDelegate.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/6/21.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    // setup the window
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    
    // setup the view controllers
    let firstVC = UINavigationController(rootViewController: CompositionalLayoutViewController())
    firstVC.title = "Compositional Layout"
    firstVC.tabBarItem.image = UIImage(systemName: "house")
    
    let secondVC = UINavigationController(rootViewController: AppStoreLayoutClone())
    secondVC.title = "App Store Layout"
    secondVC.tabBarItem.image = UIImage(systemName: "bell")
    
    // Setup Tabbar view coontroller
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([firstVC,secondVC ], animated: true)
    tabBarVC.modalPresentationStyle = .fullScreen

    window?.rootViewController = tabBarVC
    
    return true
  }
}
