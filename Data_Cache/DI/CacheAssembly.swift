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
        container.register(GithubOrgCacher.self) { _ in
            GithubOrgCacher()
        }.inObjectScope(.container)
        container.register(GithubOrgsCacher.self) { _ in
            GithubOrgsCacher()
        }.inObjectScope(.container)
        container.register(GithubReposCacher.self) { _ in
            GithubReposCacher()
        }.inObjectScope(.container)
    }
}
