//
//  ViewModelAssembly.swift
//  Presentation.ViewModel
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Swinject

public struct ViewModelAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubOrgsViewModel.self) { resolver in
            GithubOrgsViewModel()
        }
        container.register(GithubReposViewModel.self) { resolver, userName in
            GithubReposViewModel(githubOrgName: userName)
        }
    }
}
