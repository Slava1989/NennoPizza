//
//  AppDelegate.swift
//  NennoPizza
//
//  Created by Slava Chirita on 01.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let configurator = HomeConfigurator()
        let homeViewController = configurator.configureHomeScreen()
        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
