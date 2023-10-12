//
//  CoreDataMoviesResponseStorage.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import Foundation
import CoreData

final class CoreDataTeamsResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest() -> NSFetchRequest<LeagueResponseEntity> {
        let request: NSFetchRequest = LeagueResponseEntity.fetchRequest()
//        request.predicate = NSPredicate(format: "%K = %@ AND %K = %d",
//                                        #keyPath(MoviesRequestEntity.query), requestDto.query,
//                                        #keyPath(MoviesRequestEntity.page), requestDto.page)
        return request
    }

    private func deleteResponse(
        for requestDto: MoviesRequestDTO,
        in context: NSManagedObjectContext
    ) {
        
        let request = fetchRequest()

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataTeamsResponseStorage: TeamsResponseStorage {
    

    func getResponse(
        completion: @escaping (Result<LeaguesResponseDTO?, Error>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest()
                let requestEntity = try context.fetch(fetchRequest)
//                let requestEntity = try context.fetch(fetchRequest).first
                completion(.success(LeaguesResponseDTO(leagues: requestEntity.map({$0.toDTO()}))))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }

    func save(
        response responseDto: LeaguesResponseDTO,
        for requestDto: MoviesRequestDTO
    ) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

//                let requestEntity = requestDto.toEntity(in: context)
//                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}

