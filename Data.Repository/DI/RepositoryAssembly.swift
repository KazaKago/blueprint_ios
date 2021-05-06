//
//  RepositoryAssembly.swift
//  Data.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject
import Domain_Repository

public struct RepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubRepository.self) { _ in
            GithubRepositoryImpl()
        }
    }
}
