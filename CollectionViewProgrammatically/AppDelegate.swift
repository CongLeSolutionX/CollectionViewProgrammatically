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
    firstVC.tabBarItem.image = UIImage(systemName: "rectangle.3.offgrid")
    
    let secondVC = UINavigationController(rootViewController: FlowLayoutViewController())
    secondVC.title = "Flow Layout"
    secondVC.tabBarItem.image = UIImage(systemName: "square.grid.3x2.fill")
    
    let thirdVC = UINavigationController(rootViewController: AppStoreLayoutViewController())
    thirdVC.title = "App Store Layout"
    thirdVC.tabBarItem.image = UIImage(systemName: "applelogo")
    
    // Setup Tabbar view coontroller
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([firstVC,secondVC, thirdVC], animated: true)
    tabBarVC.modalPresentationStyle = .fullScreen

    window?.rootViewController = tabBarVC
    
    return true
  }
}
