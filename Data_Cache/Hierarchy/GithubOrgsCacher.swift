//
//  GithubOrgsCacher.swift
//  Data.Cache
//
//  Created by Kensuke Tamura on 2021/05/07.
//

import Foundation
import StoreFlowable

public class GithubOrgsCacher: PaginationCacher<UnitHash, GithubOrgEntity> {
    public override var expireSeconds: TimeInterval {
        get { TimeInterval(60 * 30) }
    }
}
