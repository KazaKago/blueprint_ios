//
//  GithubRepository.swift
//  Domain.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import StoreFlowable
import Domain_Model

public protocol GithubRepository {

    func getOrgsPublisher() -> LoadingStateSequence<[GithubOrg]>

    func refreshOrgs() async

    func requestAdditionalOrgs(continueWhenError: Bool) async

    func getOrgPublisher(githubOrgName: GithubOrgName) -> LoadingStateSequence<GithubOrg>

    func refreshOrg(githubOrgName: GithubOrgName) async

    func getReposPublisher(githubOrgName: GithubOrgName) -> LoadingStateSequence<[GithubRepo]>

    func refreshRepos(githubOrgName: GithubOrgName) async

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) async
}
