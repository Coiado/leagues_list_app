//
//  DefaultTeamBadgesRepository.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

final class DefaultTeamBadgesRepository {
    
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultTeamBadgesRepository: TeamsBadgeRepository {
    
    func fetchImage(
        with imagePath: String,
        width: Int,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable? {
        
        let endpoint = APIEndpoints.getMoviePoster(path: imagePath, width: width)
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(
            with: endpoint,
            on: backgroundQueue
        ) { (result: Result<Data, DataTransferError>) in

            let result = result.mapError { $0 as Error }
            completion(result)
        }
        return task
    }
}

