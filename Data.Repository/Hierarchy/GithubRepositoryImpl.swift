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

    private let githubService: GithubService
    private let githubCache: GithubCache
    private let githubOrgResponseMapper: GithubOrgResponseMapper
    private let githubRepoResponseMapper: GithubRepoResponseMapper
    private let githubOrgEntityMapper: GithubOrgEntityMapper
    private let githubRepoEntityMapper: GithubRepoEntityMapper

    init(githubService: GithubService, githubCache: GithubCache, githubOrgResponseMapper: GithubOrgResponseMapper, githubRepoResponseMapper: GithubRepoResponseMapper, githubOrgEntityMapper: GithubOrgEntityMapper, githubRepoEntityMapper: GithubRepoEntityMapper) {
        self.githubService = githubService
        self.githubCache = githubCache
        self.githubOrgResponseMapper = githubOrgResponseMapper
        self.githubRepoResponseMapper = githubRepoResponseMapper
        self.githubOrgEntityMapper = githubOrgEntityMapper
        self.githubRepoEntityMapper = githubRepoEntityMapper
    }

    func followOrgs() -> StatePublisher<[GithubOrg]> {
        let githubOrgsFlowable = GithubOrgsFlowableCallback(githubService: githubService, githubCache: githubCache, githubOrgResponseMapper: githubOrgResponseMapper).create()
        return githubOrgsFlowable.publish().mapContent { data in
            data.map { githubOrgEntity in
                githubOrgEntityMapper.map(entity: githubOrgEntity)
            }
        }.eraseToAnyPublisher()
    }

    func refreshOrgs() -> AnyPublisher<Void, Never> {
        let githubOrgsFlowable = GithubOrgsFlowableCallback(githubService: githubService, githubCache: githubCache, githubOrgResponseMapper: githubOrgResponseMapper).create()
        return githubOrgsFlowable.refresh()
    }

    func requestAdditionalOrgs(continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        let githubOrgsFlowable = GithubOrgsFlowableCallback(githubService: githubService, githubCache: githubCache, githubOrgResponseMapper: githubOrgResponseMapper).create()
        return githubOrgsFlowable.requestAdditionalData(continueWhenError: continueWhenError)
    }

    func followRepos(githubOrgName: GithubOrgName) -> StatePublisher<[GithubRepo]> {
        let githubReposFlowable = GithubReposFlowableCallback(githubService: githubService, githubCache: githubCache, githubRepoResponseMapper: githubRepoResponseMapper, githubOrgName: githubOrgName).create()
        return githubReposFlowable.publish().mapContent { data in
            data.map { githubRepoEntity in
                githubRepoEntityMapper.map(entity: githubRepoEntity)
            }
        }.eraseToAnyPublisher()
    }

    func refreshRepos(githubOrgName: GithubOrgName) -> AnyPublisher<Void, Never> {
        let githubReposFlowable = GithubReposFlowableCallback(githubService: githubService, githubCache: githubCache, githubRepoResponseMapper: githubRepoResponseMapper, githubOrgName: githubOrgName).create()
        return githubReposFlowable.refresh()
    }

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) -> AnyPublisher<Void, Never> {
        let githubReposFlowable = GithubReposFlowableCallback(githubService: githubService, githubCache: githubCache, githubRepoResponseMapper: githubRepoResponseMapper, githubOrgName: githubOrgName).create()
        return githubReposFlowable.requestAdditionalData(continueWhenError: continueWhenError)
    }
}
