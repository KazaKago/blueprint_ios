//
//  GithubOrgEntityMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Domain_Model
import Data_Cache

public struct GithubOrgEntityMapper {

    public func map(entity: GithubOrgEntity) -> GithubOrg {
        GithubOrg(
            id: GithubOrgId(entity.id),
            name: GithubOrgName(entity.name),
            imageUrl: URL(string: entity.imageUrl)!
        )
    }
}
