//
//  MoviesRequestDTO+Mapping.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
