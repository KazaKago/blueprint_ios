//
//  GithubOrg.swift
//  Domain.Model
//
//  Created by Kensuke Tamura on 2021/04/30.
//

import Foundation

public struct GithubOrg: Equatable, Identifiable {
    public let id: GithubOrgId
    public let name: GithubOrgName

    public init(id: GithubOrgId, name: GithubOrgName) {
        self.id = id
        self.name = name
    }
}
