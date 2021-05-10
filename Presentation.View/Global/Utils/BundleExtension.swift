//
//  BundleExtension.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import Foundation

extension Bundle {

    static var current: Bundle {
        class TypeAccessor {}
        return Bundle(for: type(of: TypeAccessor()))
    }
}
