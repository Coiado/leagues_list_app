//
//  SceneDelegate.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
        
    private let coordinator: Coordinator<TeamsRouter> = .init(
        startingRoute: .teams,
        appDIContainer: AppDIContainer()
    )
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}
