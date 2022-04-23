//
//  GithubOrgFlowableFactory.swift
//  Data_Repository
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import Combine
import StoreFlowable
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubOrgFlowableFactory: StoreFlowableFactory {

    typealias KEY = String
    typealias DATA = GithubOrgEntity

    private static let EXPIRED_DURATION = TimeInterval(60 * 30)
    private let githubApi: GithubApi
    private let githubCache: GithubCache
    private let githubOrgResponseMapper: GithubOrgResponseMapper
    let flowableDataStateManager: FlowableDataStateManager<String>

    init(githubApi: GithubApi, githubCache: GithubCache, githubOrgResponseMapper: GithubOrgResponseMapper, githubOrgStateManager: GithubOrgStateManager) {
        self.githubApi = githubApi
        self.githubCache = githubCache
        self.githubOrgResponseMapper = githubOrgResponseMapper
        self.flowableDataStateManager = githubOrgStateManager
    }

    func loadDataFromCache(param: String) -> AnyPublisher<GithubOrgEntity?, Never> {
        Future { promise in
            let data = githubCache.orgMapCache[param]?.value
            promise(.success(data))
        }.eraseToAnyPublisher()
    }

    func saveDataToCache(newData: GithubOrgEntity?, param: String) -> AnyPublisher<Void, Never> {
        Future { promise in
            if let newData = newData {
                githubCache.orgMapCache[param] = CacheHolder(value: newData)
            } else {
                githubCache.orgMapCache[param] = nil
            }
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    func fetchDataFromOrigin(param: String) -> AnyPublisher<GithubOrgEntity, Error> {
        githubApi.getOrg(org: param).map { response in
            githubOrgResponseMapper.map(response: response)
        }.eraseToAnyPublisher()
    }

    func needRefresh(cachedData: GithubOrgEntity, param: String) -> AnyPublisher<Bool, Never> {
        Future { promise in
            if let createdAt = githubCache.orgMapCache[param]?.createdAt {
                let expiredAt = createdAt + Self.EXPIRED_DURATION
                promise(.success(expiredAt < Date()))
            } else {
                promise(.success(true))
            }
        }.eraseToAnyPublisher()
    }
}
