//
//  GetGithubReposPublisherUseCaseImpl.swift
//  Domain.UseCase
//
//  Created by Kensuke Tamura on 2021/05/06.
//

import Foundation
import Combine
import StoreFlowable
import Domain_Model
import Domain_Repository

struct GetGithubReposPublisherUseCaseImpl: GetGithubReposPublisherUseCase {

    private let githubRepository: GithubRepository

    init(githubRepository: GithubRepository) {
        self.githubRepository = githubRepository
    }

    func invoke(githubOrgName: GithubOrgName) -> LoadingStatePublisher<GithubOrgAndRepos> {
        githubRepository.getOrgPublisher(githubOrgName: githubOrgName)
            .zipState(githubRepository.getReposPublisher(githubOrgName: githubOrgName)) { githubOrg, githubRepos in
                GithubOrgAndRepos(githubOrg: githubOrg, githubRepos: githubRepos)
            }
    }
}
