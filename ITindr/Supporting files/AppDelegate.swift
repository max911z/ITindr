//
//  AppDelegate.swift
//  ITindr
//
//  Created by Максим Неверовский on 11.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        let startVC = StartScreenViewController();
        navController.pushViewController(startVC, animated: false);
        window?.rootViewController = navController;
        window?.makeKeyAndVisible();
        return true
    }

    
    


}

