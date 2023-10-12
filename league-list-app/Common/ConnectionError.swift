//
//  ConnectionError.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

protocol ConnectionError: Error {
    var isInternetConnectionError: Bool { get }
}

extension Error {
    var isInternetConnectionError: Bool {
        guard let error = self as? ConnectionError, error.isInternetConnectionError else {
            return false
        }
        return true
    }
}

