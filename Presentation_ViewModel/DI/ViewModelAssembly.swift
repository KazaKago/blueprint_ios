//
//  ViewModelAssembly.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Swinject
import Domain_UseCase

public struct ViewModelAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubOrgsViewModel.self) { resolver in
            GithubOrgsViewModel(getGithubOrgsPublisherUseCase: resolver.resolve(GetGithubOrgsPublisherUseCase.self)!, refreshGithubOrgsUseCase: resolver.resolve(RefreshGithubOrgsUseCase.self)!, requestAdditionalGithubOrgsUseCase: resolver.resolve(RequestAdditionalGithubOrgsUseCase.self)!)
        }
        container.register(GithubReposViewModel.self) { resolver, githubOrgName in
            GithubReposViewModel(getGithubReposPublisherUseCase: resolver.resolve(GetGithubReposPublisherUseCase.self)!, refreshGithubReposUseCase: resolver.resolve(RefreshGithubReposUseCase.self)!, requestAdditionalGithubReposUseCase: resolver.resolve(RequestAdditionalGithubReposUseCase.self)!, githubOrgName: githubOrgName)
        }
        container.register(AboutViewModel.self) { resolver in
            AboutViewModel(getAboutInfoUseCase: resolver.resolve(GetAboutInfoUseCase.self)!)
        }
    }
}
