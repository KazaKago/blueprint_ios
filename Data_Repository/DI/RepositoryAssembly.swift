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
            GithubRepositoryImpl(githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!, githubRepoResponseMapper: resolver.resolve(GithubRepoResponseMapper.self)!, githubOrgEntityMapper: resolver.resolve(GithubOrgEntityMapper.self)!, githubRepoEntityMapper: resolver.resolve(GithubRepoEntityMapper.self)!, githubOrgsFetcher: resolver.resolve(GithubOrgsFetcher.self)!, githubOrgsCacher: resolver.resolve(GithubOrgsCacher.self)!, githubOrgFetcher: resolver.resolve(GithubOrgFetcher.self)!, githubOrgCacher: resolver.resolve(GithubOrgCacher.self)!, githubReposFetcher: resolver.resolve(GithubReposFetcher.self)!, githubReposCacher: resolver.resolve(GithubReposCacher.self)!)
        }.inObjectScope(.container)
        container.register(AboutRepository.self) { resolver in
            AboutRepositoryImpl(appInfoDao: resolver.resolve(AppInfoDao.self)!, developerInfoDao: resolver.resolve(DeveloperInfoDao.self)!, appInfoEntityMapper: resolver.resolve(AppInfoEntityMapper.self)!, developerInfoEntityMapper: resolver.resolve(DeveloperInfoEntityMapper.self)!)
        }.inObjectScope(.container)
        container.register(GithubOrgFetcher.self) { resolver in
            GithubOrgFetcher(githubApi: resolver.resolve(GithubApi.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!)
        }.inObjectScope(.container)
        container.register(GithubOrgsFetcher.self) { resolver in
            GithubOrgsFetcher(githubApi: resolver.resolve(GithubApi.self)!, githubOrgResponseMapper: resolver.resolve(GithubOrgResponseMapper.self)!)
        }.inObjectScope(.container)
        container.register(GithubReposFetcher.self) { resolver in
            GithubReposFetcher(githubApi: resolver.resolve(GithubApi.self)!, githubRepoResponseMapper: resolver.resolve(GithubRepoResponseMapper.self)!)
        }.inObjectScope(.container)
    }
}
