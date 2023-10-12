//
//  LeagueSceneDIContainer.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import UIKit
import SwiftUI

public protocol TeamsSearchFlowCoordinatorDependencies  {
    func makeTeamsListView() -> any View
    func makeTeamsListViewModelWrapper() -> TeamsListViewModelWrapper
}

public class TeamsSceneDIContainer: TeamsSearchFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var moviesQueriesStorage: MoviesQueriesStorage = CoreDataMoviesQueriesStorage(maxStorageLimit: 10)
    lazy var moviesResponseCache: TeamsResponseStorage = CoreDataTeamsResponseStorage()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
//    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
//        DefaultSearchMoviesUseCase(
//            moviesRepository: makeMoviesRepository(),
//            moviesQueriesRepository: makeMoviesQueriesRepository()
//        )
//    }
    
    func makeSearchMoviesUseCase() -> SearchLeaguesUseCase {
        DefaultSearchLeaguesUseCase(
            leaguesRepository: makeMoviesRepository()
        )
    }
    
    func makeFetchRecentTeamsUseCase(
        completion: @escaping (FetchRecentLeaguesUseCase.ResultValue) -> Void
    ) -> UseCase {
        FetchRecentLeaguesUseCase(
            completion: completion,
            teamsRepository: makeMoviesRepository()
        )
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> LeaguesRepository {
        DefaultLeaguesRepository(
            dataTransferService: dependencies.apiDataTransferService,
            cache: moviesResponseCache
        )
    }
    func makeTeamsBadgeRepository() -> TeamsBadgeRepository {
        DefaultTeamBadgesRepository(
            dataTransferService: dependencies.imageDataTransferService
        )
    }
    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
        DefaultMoviesQueriesRepository(
            moviesQueriesPersistentStorage: moviesQueriesStorage
        )
    }
    
    // MARK: - Movies List
    func makeTeamsListViewModel() -> TeamsListViewModel {
        DefaultTeamsListViewModel(
            searchLeaguesUseCase: makeSearchMoviesUseCase(),
            fetchLeaguesUseCaseFactory: makeFetchRecentTeamsUseCase
        )
    }
    
    public func makeTeamsListViewModelWrapper() -> TeamsListViewModelWrapper {
        TeamsListViewModelWrapper(viewModel: makeTeamsListViewModel())
    }
    
    public func makeTeamsListView() -> any View {
        TeamsListView(viewModelWrapper: makeTeamsListViewModelWrapper())
    }
    
  
}

