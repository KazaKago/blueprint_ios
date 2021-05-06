//
//  RepositoryAssembly.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject
import Domain_Repository
import Data_Mapper
import Data_Api
import Data_Cache

public struct RepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubRepository.self) { resolver in
            GithubRepositoryImpl(githubService: resolver.resolve(GithubService.self)!, githubCache: resolver.resolve(GithubCache.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!, githubRepoResponseMapper: resolver.resolve(GithubRepoResponseMapper.self)!, githubOrgEntityMapper: resolver.resolve(GithubOrgEntityMapper.self)!, githubRepoEntityMapper: resolver.resolve(GithubRepoEntityMapper.self)!)
        }.inObjectScope(.container)
    }
}
