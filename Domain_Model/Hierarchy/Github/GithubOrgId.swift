//
//  GithubOrgId.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubOrgId: Equatable, Hashable {
    public let value: Int

    public init(_ value: Int) {
        self.value = value
    }
}
