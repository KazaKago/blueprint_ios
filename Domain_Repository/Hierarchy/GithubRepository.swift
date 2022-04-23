//
//  GithubRepository.swift
//  Domain.Repository
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model

public protocol GithubRepository {

    func getOrgsPublisher() -> LoadingStatePublisher<[GithubOrg]>

    func getOrgPublisher(githubOrgName: GithubOrgName) -> LoadingStatePublisher<GithubOrg>

    func refreshOrgs() -> AnyPublisher<Void, Never>

    func requestAdditionalOrgs(continueWhenError: Bool) -> AnyPublisher<Void, Never>

    func getReposPublisher(githubOrgName: GithubOrgName) -> LoadingStatePublisher<[GithubRepo]>

    func refreshRepos(githubOrgName: GithubOrgName) -> AnyPublisher<Void, Never>

    func requestAdditionalRepos(githubOrgName: GithubOrgName, continueWhenError: Bool) -> AnyPublisher<Void, Never>
}
