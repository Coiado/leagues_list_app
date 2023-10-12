//
//  APIEndpoints.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

struct APIEndpoints {
    
    static func getLeagues() -> Endpoint<LeaguesResponseDTO> {
        return Endpoint(
            path: "/all_leagues.php",
            method: .get
        )
    }

    static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        return Endpoint(
            path: "t/p/w\(closestWidth)\(path)",
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}

