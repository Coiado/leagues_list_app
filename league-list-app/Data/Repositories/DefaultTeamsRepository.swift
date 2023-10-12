//
//  DefaultMoviesRepository.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultLeaguesRepository {

    private let dataTransferService: DataTransferService
    private let cache: TeamsResponseStorage
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
        cache: TeamsResponseStorage,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.cache = cache
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultLeaguesRepository: LeaguesRepository {
    
    func fetchLeaguesList(
        cached: @escaping ([Leagues]) -> Void,
        completion: @escaping (Result<[Leagues], Error>) -> Void
    ) -> Cancellable? {
        let task = RepositoryTask()

        cache.getResponse { [weak self, backgroundQueue] result in
            
            if case let .success(responseDTO?) = result {
                cached(responseDTO.leagues.map({$0.toDomain()}))
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getLeagues()
            task.networkTask = self?.dataTransferService.request(
                with: endpoint,
                on: backgroundQueue
            ) { result in
                switch result {
                case .success(let responseDTO):
//                    self?.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
}

