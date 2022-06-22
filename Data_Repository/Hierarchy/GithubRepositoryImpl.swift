//
//  GithubRepositoryImpl.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Domain_Model
import Domain_Repository
import Data_Mapper
import Data_Cache

struct GithubRepositoryImpl: GithubRepository {

    private let githubOrgResponseMapper: GithubOrgResponseMapper
    private let githubRepoResponseMapper: GithubRepoResponseMapper
    private let githubOrgEntityMapper: GithubOrgEntityMapper
    private let githubRepoEntityMapper: GithubRepoEntityMapper
    private let githubOrgsFetcher: GithubOrgsFetcher
    private let githubOrgsCacher: GithubOrgsCacher
    private let githubOrgFetcher: GithubOrgFetcher
    private let githubOrgCacher: GithubOrgCacher
    private let githubReposFetcher: GithubReposFetcher
    private let githubReposCacher: GithubReposCacher

    init(
        githubOrgResponseMapper: GithubOrgResponseMapper,
        githubRepoResponseMapper: GithubRepoResponseMapper,
        githubOrgEntityMapper: GithubOrgEntityMapper,
        githubRepoEntityMapper: GithubRepoEntityMapper,
        githubOrgsFetcher: GithubOrgsFetcher,
        githubOrgsCacher: GithubOrgsCacher,
        githubOrgFetcher: GithubOrgFetcher,
        githubOrgCacher: GithubOrgCacher,
        githubReposFetcher: GithubReposFetcher,
        githubReposCacher: GithubReposCacher
    ) {
        self.githubOrgResponseMapper = githubOrgResponseMapper
        self.githubRepoResponseMapper = githubRepoResponseMapper
        self.githubOrgEntityMapper = githubOrgEntityMapper
        self.githubRepoEntityMapper = githubRepoEntityMapper
        self.githubOrgsFetcher = githubOrgsFetcher
        self.githubOrgsCacher = githubOrgsCacher
        self.githubOrgFetcher = githubOrgFetcher
        self.githubOrgCacher = githubOrgCacher
        self.githubReposFetcher = githubReposFetcher
        self.githubReposCacher = githubReposCacher
    }

    func getOrgsPublisher() -> LoadingStateSequence<[GithubOrg]> {
        let githubOrgsFlowable = AnyStoreFlowable.from(cacher: githubOrgsCacher, fetcher: githubOrgsFetcher)
        return githubOrgsFlowable.publish().mapContent { data in
            data.map { githubOrgEntityMapper.map(entity: $0) }
        }
    }

    func refreshOrgs() async {
        let githubOrgsFlowable = AnyStoreFlowable.from(cacher: githubOrgsCacher, fetcher: githubOrgsFetcher)
        await githubOrgsFlowable.refresh()
    }

    func requestAdditionalOrgs(continueWhenError: Bool) async {
        let githubOrgsFlowable = AnyStoreFlowable.from(cacher: githubOrgsCacher, fetcher: githubOrgsFetcher)
        await githubOrgsFlowable.requestNextData(continueWhenError: continueWhenError)
    }

    func getOrgPublisher(githubOrgName: GithubOrgName) -> LoadingStateSequence<GithubOrg> {
        let githubOrgFlowable = AnyStoreFlowable.from(cacher: githubOrgCacher, fetcher: githubOrgFetcher, param: githubOrgName.value)
        return githubOrgFlowable.publish().mapContent { data in
            githubOrgEntityMapper.map(entity: data)
        }
    }

    func refreshOrg(githubOrgName: GithubOrgName) async {
        let githubOrgFlowable = AnyStoreFlowable.from(cacher: githubOrgCacher, fetcher: githubOrgFetcher, param: githubOrgName.value)
        await githubOrgFlowable.refresh()
    }

    func getReposPublisher(githubOrgName: GithubOrgName) -> LoadingStateSequence<[GithubRepo]> {
        let githubReposFlowable = AnyStoreFlowable.from(cacher: githubReposCacher, fetcher: githubReposFetcher, param: githubOrgName.value)
        return githubReposFlowable.publish().mapContent { data in
            data.map { githubRepoEntityMapper.map(entity: $0) }
        }
    }

    func refreshRepos(githubOrgName: GithubOrgName) async {
        let githubReposFlowable = AnyStoreFlowable.from(cacher: githubReposCacher, fetcher: githubReposFetcher, param: githubOrgName.value)
        await githubReposFlowable.refresh()
    }

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) async {
        let githubReposFlowable = AnyStoreFlowable.from(cacher: githubReposCacher, fetcher: githubReposFetcher, param: githubOrgName.value)
        await githubReposFlowable.requestNextData(continueWhenError: continueWhenError)
    }
}
