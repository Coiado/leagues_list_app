//
//  UseCase.swift
//  league-list-app
//
//  Created by Lucas Coiado Mota on 10/7/23.
//

import Foundation

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
