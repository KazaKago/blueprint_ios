//
//  RequestAdditionalGithubReposUseCase.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine

public protocol RequestAdditionalGithubReposUseCase {

    func invoke(continueWhenError: Bool) -> AnyPublisher<Void, Never>
}
