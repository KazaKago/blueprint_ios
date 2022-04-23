//
//  GithubOrgAndRepos.swift
//  Domain_Model
//
//  Created by Kensuke Tamura on 2022/04/23.
//

import Foundation

public struct GithubOrgAndRepos {
    public let githubOrg: GithubOrg
    public let githubRepos: [GithubRepo]

    public init(githubOrg: GithubOrg, githubRepos: [GithubRepo]) {
        self.githubOrg = githubOrg
        self.githubRepos = githubRepos
    }
}
