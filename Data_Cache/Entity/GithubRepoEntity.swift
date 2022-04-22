//
//  GithubRepoEntity.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubRepoEntity {
    public let id: Int
    public let name: String
    public let url: URL

    public init(id: Int, name: String, url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}
