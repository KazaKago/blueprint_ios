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
        container.register(GetGithubOrgsPublisherUseCase.self) { resolver in
            GetGithubOrgsPublisherUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(GetGithubReposPublisherUseCase.self) { resolver in
            GetGithubReposPublisherUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(RefreshGithubOrgsUseCase.self) { resolver in
            RefreshGithubOrgsUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(RefreshGithubReposUseCase.self) { resolver in
            RefreshGithubReposUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(RequestAdditionalGithubOrgsUseCase.self) { resolver in
            RequestAdditionalGithubOrgsUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(RequestAdditionalGithubReposUseCase.self) { resolver in
            RequestAdditionalGithubReposUseCaseImpl(githubRepository: resolver.resolve(GithubRepository.self)!)
        }.inObjectScope(.container)
        container.register(GetAboutInfoUseCase.self) { resolver in
            GetAboutInfoUseCaseImpl(aboutRepository: resolver.resolve(AboutRepository.self)!)
        }.inObjectScope(.container)
    }
}
