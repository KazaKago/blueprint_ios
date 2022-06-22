//
//  GithubOrgsFetcher.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubOrgsFetcher: PaginationFetcher {

    typealias PARAM = UnitHash
    typealias DATA = GithubOrgEntity

    private static let PER_PAGE = 20
    private let githubApi: GithubApi
    private let githubOrgResponseMapper: GithubOrgResponseMapper

    init(githubApi: GithubApi, githubOrgResponseMapper: GithubOrgResponseMapper) {
        self.githubApi = githubApi
        self.githubOrgResponseMapper = githubOrgResponseMapper
    }

    func fetch(param: UnitHash) async throws -> PaginationFetcher.Result<GithubOrgEntity> {
        let response = try await githubApi.getOrgs(since: nil, perPage: Self.PER_PAGE)
        let data = response.map { githubOrgResponseMapper.map(response: $0) }
        return PaginationFetcher.Result(
            data: data,
            nextRequestKey: data.last?.id.description
        )
    }

    func fetchNext(nextKey: String, param: UnitHash) async throws -> PaginationFetcher.Result<GithubOrgEntity> {
        let response = try await githubApi.getOrgs(since: Int(nextKey), perPage: Self.PER_PAGE)
        let data = response.map { githubOrgResponseMapper.map(response: $0) }
        return PaginationFetcher.Result(
            data: data,
            nextRequestKey: data.last?.id.description
        )
    }
}
