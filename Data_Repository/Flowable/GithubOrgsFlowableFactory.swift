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

struct GithubOrgsFlowableFactory: PaginationStoreFlowableFactory {

    typealias KEY = UnitHash
    typealias DATA = [GithubOrgEntity]

    private static let EXPIRED_DURATION = TimeInterval(60 * 30)
    private static let PER_PAGE = 20
    private let githubApi: GithubApi
    private let githubCache: GithubCache
    private let githubOrgResponseMapper: GithubOrgResponseMapper

    init(githubApi: GithubApi, githubCache: GithubCache, githubOrgResponseMapper: GithubOrgResponseMapper) {
        self.githubApi = githubApi
        self.githubCache = githubCache
        self.githubOrgResponseMapper = githubOrgResponseMapper
    }

    let flowableDataStateManager: FlowableDataStateManager<UnitHash> = GithubOrgsStateManager.shared

    func loadDataFromCache(param: UnitHash) -> AnyPublisher<[GithubOrgEntity]?, Never> {
        Future { promise in
            let dataList = githubCache.orgNameListCache?.value.compactMap { githubCache.orgMapCache[$0]?.value }
            promise(.success(dataList))
        }.eraseToAnyPublisher()
    }

    func saveDataToCache(newData: [GithubOrgEntity]?, param: UnitHash) -> AnyPublisher<Void, Never> {
        Future { promise in
            if let newData = newData {
                githubCache.orgNameListCache = CacheHolder(value: newData.map { $0.name })
            } else {
                githubCache.orgNameListCache = nil
            }
            newData?.forEach {
                githubCache.orgMapCache[$0.name] = CacheHolder(value: $0)
            }
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func saveNextDataToCache(cachedData: [GithubOrgEntity], newData: [GithubOrgEntity], param: UnitHash) -> AnyPublisher<Void, Never> {
        Future { promise in
            githubCache.orgNameListCache = CacheHolder(
                value: cachedData.map { $0.name } + newData.map { $0.name },
                createdAt: githubCache.orgNameListCache?.createdAt ?? Date()
            )
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func fetchDataFromOrigin(param: UnitHash) -> AnyPublisher<Fetched<[GithubOrgEntity]>, Error> {
        githubApi.getOrgs(since: nil, perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubOrgResponseMapper.map(response: $0) }
            return Fetched(
                data: data,
                nextKey: data.last?.id.description
            )
        }.eraseToAnyPublisher()
    }

    func fetchNextDataFromOrigin(nextKey: String, param: UnitHash) -> AnyPublisher<Fetched<[GithubOrgEntity]>, Error> {
        githubApi.getOrgs(since: Int(nextKey), perPage: Self.PER_PAGE).map { response in
            let data = response.map { githubOrgResponseMapper.map(response: $0) }
            return Fetched(
                data: data,
                nextKey: data.last?.id.description
            )
        }.eraseToAnyPublisher()
    }

    func needRefresh(cachedData: [GithubOrgEntity], param: UnitHash) -> AnyPublisher<Bool, Never> {
        Future { promise in
            if let createdAt = githubCache.orgNameListCache?.createdAt {
                let expiredAt = createdAt + Self.EXPIRED_DURATION
                promise(.success(expiredAt < Date()))
            } else {
                promise(.success(true))
            }
        }.eraseToAnyPublisher()
    }
}
