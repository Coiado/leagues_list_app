//
//  LeaguesListItemViewModel.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

class TeamsListItemViewModel {
    let name: String

    init(name: String) {
        self.name = name
    }
}

extension TeamsListItemViewModel: Equatable {
    static func == (lhs: TeamsListItemViewModel, rhs: TeamsListItemViewModel) -> Bool {
        return lhs.name == rhs.name
    }
}

