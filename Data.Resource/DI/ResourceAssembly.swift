//
//  ResourceAssembly.swift
//  Data.Resource
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject

public struct ResourceAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
//        container.register(GithubRepository.self) { resolver in
//            GithubRepositoryImpl(githubService: resolver.resolve(GithubService.self)!, githubCache: resolver.resolve(GithubCache.self)!)
//        }.inObjectScope(.container)
    }
}
