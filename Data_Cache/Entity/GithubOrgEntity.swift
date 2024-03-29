//
//  GithubOrgEntity.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation

public struct GithubOrgEntity {
    public let id: Int
    public let name: String
    public let imageUrl: String

    public init(id: Int, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
