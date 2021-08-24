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
    let firstVC = UINavigationController(rootViewController: FlowLayoutViewController())
    firstVC.title = "Flow Layout"
    firstVC.tabBarItem.image = UIImage(systemName: "square.grid.3x2.fill")
    
    let secondVC = UINavigationController(rootViewController: CompositionalLayoutViewController())
    secondVC.title = "Compositional Layout"
    secondVC.tabBarItem.image = UIImage(systemName: "rectangle.3.offgrid")
    
    let thirdVC = UINavigationController(rootViewController: AppCenterLayoutUsingTableViewCellsController())
    thirdVC.title = "App Store Table Cells"
    thirdVC.tabBarItem.image = UIImage(systemName: "applelogo")
    
    let fourthVC = UINavigationController(rootViewController: AppStoreViaCollectionViewDiffable())
    fourthVC.title = "App Center Diffable"
    fourthVC.tabBarItem.image = UIImage(systemName: "car")
    
    // Setup Tabbar view controller
    let tabBarVC = UITabBarController()
    tabBarVC.setViewControllers([firstVC, secondVC, thirdVC, fourthVC], animated: true)
        tabBarVC.modalPresentationStyle = .fullScreen
    
    window?.rootViewController = tabBarVC
    
    return true
  }
}
