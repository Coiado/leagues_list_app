//
//  MoviesResponseStorage.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import Foundation

protocol TeamsResponseStorage {
    func getResponse(
        completion: @escaping (Result<LeaguesResponseDTO?, Error>) -> Void
    )
    func save(response: LeaguesResponseDTO, for requestDto: MoviesRequestDTO)
}
