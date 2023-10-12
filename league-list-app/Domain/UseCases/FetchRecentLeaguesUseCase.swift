//
//  FetchRecentTeamsUseCase.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import Foundation

// This is another option to create Use Case using more generic way
final class FetchRecentLeaguesUseCase: UseCase {
    typealias ResultValue = (Result<[Leagues], Error>)

    private let completion: (ResultValue) -> Void
    private let teamsRepository: LeaguesRepository

    init(
        completion: @escaping (ResultValue) -> Void,
        teamsRepository: LeaguesRepository
    ) {
        self.completion = completion
        self.teamsRepository = teamsRepository
    }
    
    func start() -> Cancellable? {

        
//        teamsRepository.fetchTeamsList(
//            maxCount: requestValue.maxCount,
//            completion: completion
//        )
        return nil
    }
}

