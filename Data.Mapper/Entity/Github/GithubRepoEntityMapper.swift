//
//  GithubRepoEntityMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Domain_Model
import Data_Cache

public struct GithubRepoEntityMapper {

    public func map(entity: GithubRepoEntity) -> GithubRepo {
        return GithubRepo(
            id: GithubRepoId(entity.id),
            name: entity.name,
            url: entity.url
        )
    }
}
