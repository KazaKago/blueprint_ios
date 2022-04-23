//
//  GithubRepositoryImpl.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model
import Domain_Repository
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubRepositoryImpl: GithubRepository {

    private let githubApi: GithubApi
    private let githubCache: GithubCache
    private let githubOrgResponseMapper: GithubOrgResponseMapper
    private let githubRepoResponseMapper: GithubRepoResponseMapper
    private let githubOrgEntityMapper: GithubOrgEntityMapper
    private let githubRepoEntityMapper: GithubRepoEntityMapper
    private let githubOrgsFlowableFactory: GithubOrgsFlowableFactory
    private let githubOrgFlowableFactory: GithubOrgFlowableFactory
    private let githubReposFlowableFactory: GithubReposFlowableFactory

    init(
        githubApi: GithubApi,
        githubCache: GithubCache,
        githubOrgResponseMapper: GithubOrgResponseMapper,
        githubRepoResponseMapper: GithubRepoResponseMapper,
        githubOrgEntityMapper: GithubOrgEntityMapper,
        githubRepoEntityMapper: GithubRepoEntityMapper,
        githubOrgsFlowableFactory: GithubOrgsFlowableFactory,
        githubOrgFlowableFactory: GithubOrgFlowableFactory,
        githubReposFlowableFactory: GithubReposFlowableFactory
    ) {
        self.githubApi = githubApi
        self.githubCache = githubCache
        self.githubOrgResponseMapper = githubOrgResponseMapper
        self.githubRepoResponseMapper = githubRepoResponseMapper
        self.githubOrgEntityMapper = githubOrgEntityMapper
        self.githubRepoEntityMapper = githubRepoEntityMapper
        self.githubOrgsFlowableFactory = githubOrgsFlowableFactory
        self.githubOrgFlowableFactory = githubOrgFlowableFactory
        self.githubReposFlowableFactory = githubReposFlowableFactory
    }

    func getOrgsPublisher() -> LoadingStatePublisher<[GithubOrg]> {
        let githubOrgsFlowable = githubOrgsFlowableFactory.create(UnitHash())
        return githubOrgsFlowable.publish().mapContent { data in
            data.map { githubOrgEntity in
                githubOrgEntityMapper.map(entity: githubOrgEntity)
            }
        }.eraseToAnyPublisher()
    }

    func getOrgPublisher(githubOrgName: GithubOrgName) -> LoadingStatePublisher<GithubOrg> {
        let githubOrgFlowable = githubOrgFlowableFactory.create(githubOrgName.value)
        return githubOrgFlowable.publish().mapContent { data in
            githubOrgEntityMapper.map(entity: data)
        }.eraseToAnyPublisher()
    }

    func refreshOrgs() -> AnyPublisher<Void, Never> {
        let githubOrgsFlowable = githubOrgsFlowableFactory.create(UnitHash())
        return githubOrgsFlowable.refresh()
    }

    func requestAdditionalOrgs(continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        let githubOrgsFlowable = githubOrgsFlowableFactory.create(UnitHash())
        return githubOrgsFlowable.requestNextData(continueWhenError: continueWhenError)
    }

    func getReposPublisher(githubOrgName: GithubOrgName) -> LoadingStatePublisher<[GithubRepo]> {
        let githubReposFlowable = githubReposFlowableFactory.create(githubOrgName.value)
        return githubReposFlowable.publish().mapContent { data in
            data.map { githubRepoEntity in
                githubRepoEntityMapper.map(entity: githubRepoEntity)
            }
        }.eraseToAnyPublisher()
    }

    func refreshRepos(githubOrgName: GithubOrgName) -> AnyPublisher<Void, Never> {
        let githubReposFlowable = githubReposFlowableFactory.create(githubOrgName.value)
        return githubReposFlowable.refresh()
    }

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        let githubReposFlowable = githubReposFlowableFactory.create(githubOrgName.value)
        return githubReposFlowable.requestNextData(continueWhenError: continueWhenError)
    }
}
