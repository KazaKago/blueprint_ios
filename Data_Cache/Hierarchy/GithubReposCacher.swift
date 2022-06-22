//
//  GithubReposCacher.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import StoreFlowable

public class GithubReposCacher: PaginationCacher<String, GithubRepoEntity> {
    public override var expireSeconds: TimeInterval {
        get { TimeInterval(60 * 30) }
    }
}
