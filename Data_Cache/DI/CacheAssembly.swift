//
//  CacheAssembly.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject

public struct CacheAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubCache.self) { _ in
            GithubCache()
        }.inObjectScope(.container)
        container.register(GithubOrgStateManager.self) { _ in
            GithubOrgStateManager()
        }.inObjectScope(.container)
        container.register(GithubOrgsStateManager.self) { _ in
            GithubOrgsStateManager()
        }.inObjectScope(.container)
        container.register(GithubReposStateManager.self) { _ in
            GithubReposStateManager()
        }.inObjectScope(.container)
    }
}
