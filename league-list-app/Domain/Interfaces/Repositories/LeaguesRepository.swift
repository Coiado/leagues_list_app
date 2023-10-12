//
//  LeaguesRepository.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

protocol LeaguesRepository {
    @discardableResult
    func fetchLeaguesList(
        cached: @escaping ([Leagues]) -> Void,
        completion: @escaping (Result<[Leagues], Error>) -> Void
    ) -> Cancellable?
    
    
}
