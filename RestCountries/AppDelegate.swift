//
//  AppDelegate.swift
//  RestCountries
//
//  Created by Kisacka on 18/09/2020.
//  Copyright © 2020 Kisacka. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // starting window
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //making window visible
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        
        
        
        return true
    }

    


}

