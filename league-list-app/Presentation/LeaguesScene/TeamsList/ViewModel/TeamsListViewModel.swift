//
//  LeaguesListViewModel.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

typealias TeamsListViewModelDidSelectAction = (Leagues) -> Void

protocol TeamsListViewModelInput {
    func viewWillAppear()
    func onTapSearchBar()
    func didSelect(item: TeamsListItemViewModel)
}

protocol TeamsListViewModelOutput {
    var items: Observable<[TeamsListItemViewModel]> { get }
}

protocol TeamsListViewModel: TeamsListViewModelInput, TeamsListViewModelOutput { }

typealias FetchLeaguesUseCaseFactory = (
    @escaping (FetchRecentLeaguesUseCase.ResultValue) -> Void
) -> UseCase

final class DefaultTeamsListViewModel: TeamsListViewModel {
    
    private let fetchLeaguesUseCaseFactory: FetchLeaguesUseCaseFactory
    private let searchLeaguesUseCase: SearchLeaguesUseCase
    private let didSelect: TeamsListViewModelDidSelectAction?
    private let mainQueue: DispatchQueueType
    let error: Observable<String> = Observable("")
    
    private var leaguesLoadTask: Cancellable? { willSet { leaguesLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    let items: Observable<[TeamsListItemViewModel]> = Observable([])
    
    init(
        searchLeaguesUseCase: SearchLeaguesUseCase,
        fetchLeaguesUseCaseFactory: @escaping FetchLeaguesUseCaseFactory,
        didSelect: TeamsListViewModelDidSelectAction? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.fetchLeaguesUseCaseFactory = fetchLeaguesUseCaseFactory
        self.searchLeaguesUseCase = searchLeaguesUseCase
        self.didSelect = didSelect
        self.mainQueue = mainQueue
    }
    
    private func updateMoviesQueries() {
        let completion: (FetchRecentLeaguesUseCase.ResultValue) -> Void = { [weak self] result in
            self?.mainQueue.async {
                switch result {
                case .success(let items):
                    print(items)
                    self?.items.value = items.map({$0.strLeague ?? ""})
                        .map(TeamsListItemViewModel.init)
                case .failure:
                    break
                }
            }
        }
        let useCase = fetchLeaguesUseCaseFactory(completion)
        useCase.start()
    }
    
    func loadLeagues() {
        leaguesLoadTask = searchLeaguesUseCase.execute(
            cached: { [weak self] leagues in
                self?.mainQueue.async {
                    print(leagues)
                }
            },
            completion: { [weak self] result in
                self?.mainQueue.async {
                    switch result {
                    case .success(let leagues):
                        self?.items.value = leagues.map({$0.strLeague ?? ""})
                            .map(TeamsListItemViewModel.init)
                    case .failure(let error):
                        self?.handle(error: error)
                    }
//                    self?.loading.value = .none
                }
        })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
}

// MARK: - INPUT. View event methods
extension DefaultTeamsListViewModel {
        
    func viewWillAppear() {
        
    }
    
    func onTapSearchBar() {
        loadLeagues()
    }
    
    func didSelect(item: TeamsListItemViewModel) {
//        didSelect?(MovieQuery(query: item.query))
    }
}

