//
//  RefreshGithubReposUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine

class RefreshGithubReposUseCaseImpl: RefreshGithubReposUseCase {

    func invoke() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
