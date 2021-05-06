//
//  UseCaseAssembly.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject

public struct UseCaseAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FollowGithubOrgsUseCase.self) { _ in
            FollowGithubOrgsUseCaseImpl()
        }
        container.register(FollowGithubReposUseCase.self) { _ in
            FollowGithubReposUseCaseImpl()
        }
        container.register(RefreshGithubOrgsUseCase.self) { _ in
            RefreshGithubOrgsUseCaseImpl()
        }
        container.register(RefreshGithubReposUseCase.self) { _ in
            RefreshGithubReposUseCaseImpl()
        }
        container.register(RequestAdditionalGithubOrgsUseCase.self) { _ in
            RequestAdditionalGithubOrgsUseCaseImpl()
        }
        container.register(RequestAdditionalGithubReposUseCase.self) { _ in
            RequestAdditionalGithubReposUseCaseImpl()
        }
    }
}
