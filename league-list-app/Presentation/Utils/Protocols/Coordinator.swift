//
//  Coordinator.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation
import UIKit
import SwiftUI

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    private let appDIContainer: AppDIContainer
    private let dependencies: TeamsSearchFlowCoordinatorDependencies
    
    public init(
        navigationController: UINavigationController = .init(),
        startingRoute: Router? = nil,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
        self.appDIContainer = appDIContainer
        self.dependencies = appDIContainer.makeTeamsSceneDIContainer()
    }
    
    public func start() {
        guard let route = startingRoute else { return }
        show(route)
    }
    
    public func show(_ route: Router, animated: Bool = true) {
        
        let view = route.view(dependecies: self.dependencies)
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            /// because there is a leak in UIHostingControllers that prevents from deallocation
            self?.navigationController.viewControllers = []
        }
    }
}
