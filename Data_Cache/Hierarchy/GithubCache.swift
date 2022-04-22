//
//  GithubCache.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public class GithubCache {
    public var orgsCache: [GithubOrgEntity]?
    public var orgsCacheCreatedAt: Date?

    public var reposCache: [String: [GithubRepoEntity]] = [:]
    public var reposCacheCreatedAt: [String: Date] = [:]
}
