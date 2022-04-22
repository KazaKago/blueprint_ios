//
//  GithubRepoResponseMapper.swift
//  Data.Mapper
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import Data_Api
import Data_Cache

public struct GithubRepoResponseMapper {

    public func map(response: GithubRepoResponse) -> GithubRepoEntity {
        GithubRepoEntity(
            id: response.id,
            name: response.fullName,
            url: URL(string: response.htmlUrl)!
        )
    }
}
