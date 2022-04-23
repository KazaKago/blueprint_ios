//
//  GithubCache.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public class GithubCache {
    public var orgNameListCache: CacheHolder<[String]>? = nil
    public var orgMapCache: [String: CacheHolder<GithubOrgEntity>] = [:]
    public var reposMapCache: [String: CacheHolder<[GithubRepoEntity]>] = [:]
}
