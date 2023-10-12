//
//  LeaguesListView.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension TeamsListItemViewModel: Identifiable { }

@available(iOS 13.0, *)
struct TeamsListView: View {
    @ObservedObject var viewModelWrapper: TeamsListViewModelWrapper
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            NavigationStack {
                List(viewModelWrapper.items) { item in
                    Button(action: {
                        
                    }) {
                        Text(item.name)
                    }
                }
            }
            .searchable(
                text: $searchText,
                prompt: "Search by League"
            )
            .onChange(of: searchText, perform: { newValue in
                if !searchText.isEmpty {
                    self.viewModelWrapper.search(text: searchText)
                }
            })
            .onTapGesture {
                if !searchText.isEmpty {
                    self.viewModelWrapper.viewModel?.onTapSearchBar()
                }
            }
        }
        .navigationBarHidden(true)
        
    }
}

@available(iOS 13.0, *)
public class TeamsListViewModelWrapper: ObservableObject {
    var viewModel: TeamsListViewModel?
    @Published var items: [TeamsListItemViewModel] = []
    
    init(viewModel: TeamsListViewModel?) {
        self.viewModel = viewModel
        viewModel?.items.observe(on: self) { [weak self] values in
            searchText.isEmpty
            self?.items = values }
    }
    
    func search(text: String) {
        self.items = viewModel?.items.value.filter({ value in
            value.name.contains(text)
        }) ?? []
    }
}

#if DEBUG
@available(iOS 13.0, *)
struct MoviesQueryListView_Previews: PreviewProvider {
    static var previews: some View {
//        TeamsListView()
        TeamsListView(viewModelWrapper: previewViewModelWrapper)
    }
    
    static var previewViewModelWrapper: TeamsListViewModelWrapper = {
        var viewModel = TeamsListViewModelWrapper(viewModel: nil)
        viewModel.items = [TeamsListItemViewModel(name: "item 1"),
                           TeamsListItemViewModel(name: "item 2")
        ]
        return viewModel
    }()
}
#endif

