//
//  GithubOrgName.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubOrgName: Equatable, Hashable {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }
}
