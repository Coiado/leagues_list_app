//
//  AppDelegate.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    let appDIContainer = AppDIContainer()
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
//        AppAppearance.setupAppearance()
    
        return true
    }
    
    func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions
        ) -> UISceneConfiguration {
            let sessionRole = connectingSceneSession.role
            let sceneConfig = UISceneConfiguration(name: nil, sessionRole: sessionRole)
            sceneConfig.delegateClass = SceneDelegate.self
            return sceneConfig
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStorage.shared.saveContext()
    }
}
