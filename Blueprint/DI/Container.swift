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

let container: Container = {
    let container = Container()
    Assembler(container: container).apply(assemblies: [
        ViewModelAssembly(),
        UseCaseAssembly(),
        RepositoryAssembly(),
    ])
    return container
}()
