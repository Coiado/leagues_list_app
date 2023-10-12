//
//  MoviesResponseEntity+Mapping.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/8/23.
//

import Foundation
import CoreData

extension LeagueResponseEntity {
    func toDTO() -> LeaguesResponseDTO.LeagueDTO {
        return .init(
            idLeague: String(id),
            strLeague: strLeague,
            strSport: strSport,
            strLeagueAlternate: strLeagueAlternate
        )
    }
}

extension LeaguesResponseDTO.LeagueDTO {
    func toEntity(in context: NSManagedObjectContext) -> LeagueResponseEntity {
        let entity: LeagueResponseEntity = .init(context: context)
        entity.id = Int64(idLeague) ?? 0
        entity.strSport = strSport
        entity.strLeague = strLeague
        entity.strLeagueAlternate = strLeagueAlternate
        return entity
    }
}

