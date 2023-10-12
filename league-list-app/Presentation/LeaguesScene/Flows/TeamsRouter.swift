//
//  TeamsRouter.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import SwiftUI

public enum TeamsRouter: NavigationRouter {
    
    case teams
    
    public var transition: NavigationTranisitionStyle {
        switch self {
        case .teams:
            return .push
        }
    }
    
    @ViewBuilder
    public func view(
        dependecies: TeamsSearchFlowCoordinatorDependencies
    ) -> some View {
        switch self {
        case .teams:
            TeamsListView(viewModelWrapper: dependecies.makeTeamsListViewModelWrapper())
        }
    }
}
