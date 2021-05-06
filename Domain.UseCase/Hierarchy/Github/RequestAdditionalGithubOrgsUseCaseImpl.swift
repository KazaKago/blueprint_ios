//
//  RequestAdditionalGithubOrgsUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine

class RequestAdditionalGithubOrgsUseCaseImpl: RequestAdditionalGithubOrgsUseCase {

    func invoke(continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
