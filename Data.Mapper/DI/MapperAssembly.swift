//
//  MapperAssembly.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Swinject

public struct MapperAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubOrgResponseMapper.self) { _ in
            GithubOrgResponseMapper()
        }.inObjectScope(.container)
        container.register(GithubRepoResponseMapper.self) { _ in
            GithubRepoResponseMapper()
        }.inObjectScope(.container)
        container.register(GithubOrgEntityMapper.self) { _ in
            GithubOrgEntityMapper()
        }.inObjectScope(.container)
        container.register(GithubRepoEntityMapper.self) { _ in
            GithubRepoEntityMapper()
        }.inObjectScope(.container)
    }
}
