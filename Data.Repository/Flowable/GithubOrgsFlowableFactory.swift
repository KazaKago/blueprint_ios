//
//  GithubOrgsFlowableFactory.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubOrgsFlowableFactory: PaginatingStoreFlowableFactory {

    typealias KEY = UnitHash
    typealias DATA = [GithubOrgEntity]

    private static let EXPIRED_DURATION = TimeInterval(60 * 30)
    private static let PER_PAGE = 20
    private let githubService: GithubService
    private let githubCache: GithubCache
    private let githubOrgResponseMapper: GithubOrgResponseMapper

    init(githubService: GithubService, githubCache: GithubCache, githubOrgResponseMapper: GithubOrgResponseMapper) {
        self.githubService = githubService
        self.githubCache = githubCache
        self.githubOrgResponseMapper = githubOrgResponseMapper
    }

    let key: UnitHash = UnitHash()

    let flowableDataStateManager: FlowableDataStateManager<UnitHash> = GithubOrgsStateManager.shared

    func loadDataFromCache() -> AnyPublisher<[GithubOrgEntity]?, Never> {
        Future { promise in
            promise(.success(githubCache.orgsCache))
        }.eraseToAnyPublisher()
    }

    func saveDataToCache(newData: [GithubOrgEntity]?) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.orgsCache = newData
            githubCache.orgsCacheCreatedAt = Date()
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func saveAdditionalDataToCache(cachedData: [GithubOrgEntity]?, newData: [GithubOrgEntity]) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.orgsCache = (cachedData ?? []) + newData
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func fetchDataFromOrigin() -> AnyPublisher<FetchingResult<[GithubOrgEntity]>, Error> {
        githubService.getOrgs(since: nil, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubOrgResponseMapper.map(response: $0) }
            return FetchingResult(data: data, noMoreAdditionalData: data.isEmpty)
        }.eraseToAnyPublisher()
    }

    func fetchAdditionalDataFromOrigin(cachedData: [GithubOrgEntity]?) -> AnyPublisher<FetchingResult<[GithubOrgEntity]>, Error> {
        let since = cachedData?.last?.id ?? nil
        return githubService.getOrgs(since: since, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubOrgResponseMapper.map(response: $0) }
            return FetchingResult(data: data, noMoreAdditionalData: data.isEmpty)
        }.eraseToAnyPublisher()
    }

    func needRefresh(cachedData: [GithubOrgEntity]) -> AnyPublisher<Bool, Never> {
        Future { promise in
            if let createdAt = githubCache.orgsCacheCreatedAt {
                let expiredAt = createdAt + Self.EXPIRED_DURATION
                promise(.success(expiredAt < Date()))
            } else {
                promise(.success(true))
            }
        }.eraseToAnyPublisher()
    }
}
