//
//  GithubOrgCacher.swift
//  Data_Cache
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation
import StoreFlowable

public class GithubOrgCacher: Cacher<String, GithubOrgEntity> {
    public override var expireSeconds: TimeInterval {
        get { TimeInterval(60 * 30) }
    }
}
