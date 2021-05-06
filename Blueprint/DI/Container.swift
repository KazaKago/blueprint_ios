//
//  DIContainer.swift
//  Blueprint
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation
import Swinject
import Presentation_View
import Presentation_ViewModel

let container: Container = {
    let container = Container()
    Assembler(container: container).apply(assemblies: [
        ViewModelAssembly(),
    ])
    return container
}()
