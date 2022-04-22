//
//  GithubRepo.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/05.
//

import Foundation

public struct GithubRepo: Equatable, Identifiable {
    public let id: GithubRepoId
    public let name: String
    public let url: URL

    public init(id: GithubRepoId, name: String, url: URL) {
        self.id = id
        self.name = name
        self.url = url
    }
}
