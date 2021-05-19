//
//  GithubReposFlowableFactory.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubReposFlowableFactory: PaginatingStoreFlowableFactory {

    typealias KEY = String
    typealias DATA = [GithubRepoEntity]

    private static let EXPIRED_DURATION = TimeInterval(60 * 30)
    private static let PER_PAGE = 20
    private let githubService: GithubService
    private let githubCache: GithubCache
    private let githubRepoResponseMapper: GithubRepoResponseMapper

    init(githubService: GithubService, githubCache: GithubCache, githubRepoResponseMapper: GithubRepoResponseMapper, githubOrgName: GithubOrgName) {
        self.githubService = githubService
        self.githubCache = githubCache
        self.githubRepoResponseMapper = githubRepoResponseMapper
        self.key = githubOrgName.value
    }

    let key: String

    let flowableDataStateManager: FlowableDataStateManager<String> = GithubReposStateManager.shared

    func loadDataFromCache() -> AnyPublisher<[GithubRepoEntity]?, Never> {
        Future { promise in
            promise(.success(githubCache.reposCache[key]))
        }.eraseToAnyPublisher()
    }

    func saveDataToCache(newData: [GithubRepoEntity]?) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.reposCache[key] = newData
            githubCache.reposCacheCreatedAt[key] = Date()
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func saveAdditionalDataToCache(cachedData: [GithubRepoEntity]?, newData: [GithubRepoEntity]) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.reposCache[key] = (cachedData ?? []) + newData
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func fetchDataFromOrigin() -> AnyPublisher<FetchingResult<[GithubRepoEntity]>, Error> {
        githubService.getRepos(org: key, page: 1, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubRepoResponseMapper.map(response: $0) }
            return FetchingResult(data: data, noMoreAdditionalData: data.isEmpty)
        }.eraseToAnyPublisher()
    }

    func fetchAdditionalDataFromOrigin(cachedData: [GithubRepoEntity]?) -> AnyPublisher<FetchingResult<[GithubRepoEntity]>, Error> {
        let page = ((cachedData?.count ?? 0) / Self.PER_PAGE + 1)
        return githubService.getRepos(org: key, page: page, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubRepoResponseMapper.map(response: $0) }
            return FetchingResult(data: data, noMoreAdditionalData: data.isEmpty)
        }.eraseToAnyPublisher()
    }

    func needRefresh(cachedData: [GithubRepoEntity]) -> AnyPublisher<Bool, Never> {
        Future { promise in
            if let createdAt = githubCache.reposCacheCreatedAt[key] {
                let expiredAt = createdAt + Self.EXPIRED_DURATION
                promise(.success(expiredAt < Date()))
            } else {
                promise(.success(true))
            }
        }.eraseToAnyPublisher()
    }
}
