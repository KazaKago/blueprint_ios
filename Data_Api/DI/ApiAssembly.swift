//
//  ApiAssembly.swift
//  Data.Api
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Swinject

public struct ApiAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(GithubService.self) { _ in
            GithubService()
        }.inObjectScope(.container)
    }
}
