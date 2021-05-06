//
//  GithubOrgResponse.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubOrgResponse: Codable {
    public let id: Int
    public let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "login"
   }
}
