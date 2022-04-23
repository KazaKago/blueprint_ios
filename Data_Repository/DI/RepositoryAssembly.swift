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
import Data_Resource

public struct RepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubRepository.self) { resolver in
            GithubRepositoryImpl(githubApi: resolver.resolve(GithubApi.self)!, githubCache: resolver.resolve(GithubCache.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!, githubRepoResponseMapper: resolver.resolve(GithubRepoResponseMapper.self)!, githubOrgEntityMapper: resolver.resolve(GithubOrgEntityMapper.self)!, githubRepoEntityMapper: resolver.resolve(GithubRepoEntityMapper.self)!, githubOrgsFlowableFactory: resolver.resolve(GithubOrgsFlowableFactory.self)!, githubOrgFlowableFactory: resolver.resolve(GithubOrgFlowableFactory.self)!, githubReposFlowableFactory: resolver.resolve(GithubReposFlowableFactory.self)!)
        }.inObjectScope(.container)
        container.register(AboutRepository.self) { resolver in
            AboutRepositoryImpl(appInfoDao: resolver.resolve(AppInfoDao.self)!, developerInfoDao: resolver.resolve(DeveloperInfoDao.self)!, appInfoEntityMapper: resolver.resolve(AppInfoEntityMapper.self)!, developerInfoEntityMapper: resolver.resolve(DeveloperInfoEntityMapper.self)!)
        }.inObjectScope(.container)
        container.register(GithubOrgFlowableFactory.self) { resolver in
            GithubOrgFlowableFactory(githubApi: resolver.resolve(GithubApi.self)!, githubCache: resolver.resolve(GithubCache.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!, githubOrgStateManager: resolver.resolve(GithubOrgStateManager.self)!)
        }.inObjectScope(.container)
        container.register(GithubOrgsFlowableFactory.self) { resolver in
            GithubOrgsFlowableFactory(githubApi: resolver.resolve(GithubApi.self)!, githubCache: resolver.resolve(GithubCache.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!, githubOrgsStateManager: resolver.resolve(GithubOrgsStateManager.self)!)
        }.inObjectScope(.container)
        container.register(GithubReposFlowableFactory.self) { resolver in
            GithubReposFlowableFactory(githubApi: resolver.resolve(GithubApi.self)!, githubCache: resolver.resolve(GithubCache.self)!, githubRepoResponseMapper: resolver.resolve(GithubRepoResponseMapper.self)!, githubReposStateManager: resolver.resolve(GithubReposStateManager.self)!)
        }.inObjectScope(.container)
    }
}
