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
        container.register(DeveloperInfoDao.self) { _ in
            DeveloperInfoDao()
        }.inObjectScope(.container)
        container.register(AppInfoDao.self) { _ in
            AppInfoDao()
        }.inObjectScope(.container)
    }
}
