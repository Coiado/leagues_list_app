//
//  NavigationTranisitionStyle.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation
import SwiftUI

public enum NavigationTranisitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

public protocol NavigationRouter {
    
    associatedtype V: View

    var transition: NavigationTranisitionStyle { get }
    
    /// Creates and returns a view of assosiated type
    ///
    @ViewBuilder
    func view(dependecies: TeamsSearchFlowCoordinatorDependencies) -> V
}
