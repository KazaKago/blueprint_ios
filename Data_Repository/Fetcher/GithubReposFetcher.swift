//
//  GithubReposFetcher.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import StoreFlowable
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubReposFetcher: PaginationFetcher {

    typealias PARAM = String
    typealias DATA = GithubRepoEntity

    private static let PER_PAGE = 20
    private let githubApi: GithubApi
    private let githubRepoResponseMapper: GithubRepoResponseMapper

    init(githubApi: GithubApi, githubRepoResponseMapper: GithubRepoResponseMapper) {
        self.githubApi = githubApi
        self.githubRepoResponseMapper = githubRepoResponseMapper
    }

    func fetch(param: String) async throws -> PaginationFetcher.Result<GithubRepoEntity> {
        let response = try await githubApi.getRepos(org: param, page: 1, perPage: Self.PER_PAGE)
        let data = response.map { githubRepoResponseMapper.map(response: $0) }
        return PaginationFetcher.Result(
            data: data,
            nextRequestKey: !data.isEmpty ? 2.description : nil
        )
    }

    func fetchNext(nextKey: String, param: String) async throws -> PaginationFetcher.Result<GithubRepoEntity> {
        let nextPage = Int(nextKey)!
        let response = try await githubApi.getRepos(org: param, page: nextPage, perPage: Self.PER_PAGE)
        let data = response.map { githubRepoResponseMapper.map(response: $0) }
        return PaginationFetcher.Result(
            data: data,
            nextRequestKey: !data.isEmpty ? (nextPage + 1).description : nil
        )
    }
}
