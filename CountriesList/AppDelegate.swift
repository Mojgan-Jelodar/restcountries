//
//  AppDelegate.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ThemeManager.sharedInstance.apply(theme: ThemeName.light.theme)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeRouter.createModule())
        window?.makeKeyAndVisible()
        return true
    }

}
