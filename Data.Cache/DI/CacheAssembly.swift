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
        container.register(GithubCache.self) { resolver in
            GithubCache()
        }.inObjectScope(.container)
    }
}
