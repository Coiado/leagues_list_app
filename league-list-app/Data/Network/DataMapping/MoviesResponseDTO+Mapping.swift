//
//  MoviesResponseDTO+Mapping.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

// MARK: - Data Transfer Object

struct LeaguesResponseDTO: Decodable {
    let leagues: [LeagueDTO]
}

extension LeaguesResponseDTO {
    struct LeagueDTO: Decodable {
        let idLeague: String
        let strLeague: String?
        let strSport: String?
        let strLeagueAlternate: String?
    }
}

// MARK: - Mappings to Domain

//extension LeaguesResponseDTO {
//    func toDomain() -> [Leagues] {
//        return .init(leagues.map{$0  })
////        return .init(: page,
////                     totalPages: totalPages,
////                     movies: movies.map { $0.toDomain() })
//    }
//}

extension LeaguesResponseDTO.LeagueDTO {
    func toDomain() -> Leagues {
        return .init(id: Leagues.Identifier(idLeague),
                     strLeague: strLeague,
                     strSport: strSport,
                     strLeagueAlternate: strLeagueAlternate
                     )
    }
}

extension LeaguesResponseDTO {
    func toDomain() -> [Leagues] {
        return .init(leagues.map({$0.toDomain()}))
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()

