//
//  GithubRepoResponse.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubRepoResponse: Codable {
    public let id: Int
    public let fullName: String
    public let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
        case htmlUrl = "html_url"
   }
}
