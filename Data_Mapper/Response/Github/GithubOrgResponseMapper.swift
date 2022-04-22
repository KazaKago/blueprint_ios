//
//  GithubOrgResponseMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Data_Api
import Data_Cache

public struct GithubOrgResponseMapper {

    public func map(response: GithubOrgResponse) -> GithubOrgEntity {
        GithubOrgEntity(
            id: response.id,
            name: response.name
        )
    }
}
