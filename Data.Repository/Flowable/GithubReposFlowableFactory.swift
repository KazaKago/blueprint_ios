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

struct GithubReposFlowableFactory: PaginationStoreFlowableFactory {

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

    func saveNextDataToCache(cachedData: [GithubRepoEntity], newData: [GithubRepoEntity]) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.reposCache[key] = cachedData + newData
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func fetchDataFromOrigin() -> AnyPublisher<Fetched<[GithubRepoEntity]>, Error> {
        githubService.getRepos(org: key, page: 1, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubRepoResponseMapper.map(response: $0) }
            return Fetched(
                data: data,
                nextKey: !data.isEmpty ? 2.description : nil
            )
        }.eraseToAnyPublisher()
    }

    func fetchNextDataFromOrigin(nextKey: String) -> AnyPublisher<Fetched<[GithubRepoEntity]>, Error> {
        let nextPage = Int(nextKey)!
        return githubService.getRepos(org: key, page: nextPage, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubRepoResponseMapper.map(response: $0) }
            return Fetched(
                data: data,
                nextKey: !data.isEmpty ? (nextPage + 1).description : nil
            )
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
