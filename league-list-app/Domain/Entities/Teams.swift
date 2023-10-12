//
//  League.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

struct Leagues: Equatable, Identifiable {
    typealias Identifier = String
    let id: Identifier
    let strLeague: String?
    let strSport: String?
    let strLeagueAlternate: String?
}
