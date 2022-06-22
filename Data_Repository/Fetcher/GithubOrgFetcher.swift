//
//  GithubOrgFetcher.swift
//  Data_Repository
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import StoreFlowable
import Data_Mapper
import Data_Api
import Data_Cache

struct GithubOrgFetcher: Fetcher {

    typealias PARAM = String
    typealias DATA = GithubOrgEntity

    private let githubApi: GithubApi
    private let githubOrgResponseMapper: GithubOrgResponseMapper

    init(githubApi: GithubApi, githubOrgResponseMapper: GithubOrgResponseMapper) {
        self.githubApi = githubApi
        self.githubOrgResponseMapper = githubOrgResponseMapper
    }

    func fetch(param: String) async throws -> GithubOrgEntity {
        let response = try await githubApi.getOrg(org: param)
        return githubOrgResponseMapper.map(response: response)
    }
}
