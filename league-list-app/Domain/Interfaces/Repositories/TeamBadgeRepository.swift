//
//  TeamBadgeRepository.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

protocol TeamsBadgeRepository {
    func fetchImage(
        with imagePath: String,
        width: Int,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancellable?
}
