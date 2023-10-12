//
//  SearchLeaguesUseCase.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/10/23.
//

import Foundation

protocol SearchLeaguesUseCase {
    func execute(
        cached: @escaping ([Leagues]) -> Void,
        completion: @escaping (Result<[Leagues], Error>) -> Void
    ) -> Cancellable?
}

final class DefaultSearchLeaguesUseCase: SearchLeaguesUseCase {

    private let leaguesRepository: LeaguesRepository

    init(
        leaguesRepository: LeaguesRepository
    ) {
        self.leaguesRepository = leaguesRepository
    }

    func execute(
        cached: @escaping ([Leagues]) -> Void,
        completion: @escaping (Result<[Leagues], Error>) -> Void
    ) -> Cancellable? {
        
        return leaguesRepository.fetchLeaguesList(
            cached: cached,
            completion: { result in

            if case .success = result {
//                self.leaguesRepository.sa
//                self.leaguesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}

struct SearchMoviesUseCaseRequestValue {
    let query: MovieQuery
    let page: Int
}
