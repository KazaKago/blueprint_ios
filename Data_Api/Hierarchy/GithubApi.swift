//
//  GithubApi.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Alamofire

public struct GithubApi {

    private let baseApiUrl = URL(string: "https://api.github.com/")!

    public func getOrgs(since: Int?, perPage: Int) async throws -> [GithubOrgResponse] {
        var urlComponents = URLComponents(url: baseApiUrl.appendingPathComponent("organizations"), resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: perPage.description),
            URLQueryItem(name: "since", value: since?.description),
        ]
        return try await AF.request(urlComponents)
            .publish([GithubOrgResponse].self)
    }

    public func getOrg(org: String) async throws -> GithubOrgResponse {
        let urlComponents = URLComponents(url: baseApiUrl.appendingPathComponent("orgs/\(org)"), resolvingAgainstBaseURL: true)!
        return try await AF.request(urlComponents)
            .publish(GithubOrgResponse.self)
    }

    public func getRepos(org: String, page: Int?, perPage: Int) async throws -> [GithubRepoResponse] {
        var urlComponents = URLComponents(url: baseApiUrl.appendingPathComponent("orgs/\(org)/repos"), resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: perPage.description),
            URLQueryItem(name: "page", value: page?.description),
        ]
        return try await AF.request(urlComponents)
            .publish([GithubRepoResponse].self)
    }
}
