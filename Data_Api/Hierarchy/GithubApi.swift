//
//  GithubApi.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import Alamofire

public struct GithubApi {

    private let baseApiUrl = URL(string: "https://api.github.com/")!

    public func getOrgs(since: Int?, perPage: Int) -> AnyPublisher<[GithubOrgResponse], Error> {
        var urlComponents = URLComponents(url: baseApiUrl.appendingPathComponent("organizations"), resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: perPage.description),
            URLQueryItem(name: "since", value: since?.description),
        ]
        return AF.request(urlComponents)
            .publishResponse([GithubOrgResponse].self)
    }

    public func getRepos(org: String, page: Int?, perPage: Int) -> AnyPublisher<[GithubRepoResponse], Error> {
        var urlComponents = URLComponents(url: baseApiUrl.appendingPathComponent("orgs/\(org)/repos"), resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "per_page", value: perPage.description),
            URLQueryItem(name: "page", value: page?.description),
        ]
        return AF.request(urlComponents)
            .publishResponse([GithubRepoResponse].self)
    }
}
