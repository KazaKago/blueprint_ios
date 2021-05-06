//
//  UseCaseAssembly.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject
import Domain_Repository

public struct UseCaseAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FollowGithubOrgsUseCase.self) { resolver in
            FollowGithubOrgsUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
        container.register(FollowGithubReposUseCase.self) { resolver in
            FollowGithubReposUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
        container.register(RefreshGithubOrgsUseCase.self) { resolver in
            RefreshGithubOrgsUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
        container.register(RefreshGithubReposUseCase.self) { resolver in
            RefreshGithubReposUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
        container.register(RequestAdditionalGithubOrgsUseCase.self) { resolver in
            RequestAdditionalGithubOrgsUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
        container.register(RequestAdditionalGithubReposUseCase.self) { resolver in
            RequestAdditionalGithubReposUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }
    }
}
