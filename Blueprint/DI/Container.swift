//
//  DIContainer.swift
//  Blueprint
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Swinject
import Presentation_ViewModel
import Domain_UseCase
import Data_Repository
import Data_Mapper
import Data_Api
import Data_Cache
import Data_Resource

let container: Container = {
    let container = Container()
    Assembler(container: container).apply(assemblies: [
        ViewModelAssembly(),
        UseCaseAssembly(),
        RepositoryAssembly(),
        MapperAssembly(),
        ApiAssembly(),
        CacheAssembly(),
        ResourceAssembly(),
    ])
    return container
}()
